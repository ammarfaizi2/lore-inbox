Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVBAINr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVBAINr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 03:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVBAINr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 03:13:47 -0500
Received: from faye.voxel.net ([69.9.164.210]:36800 "EHLO faye.voxel.net")
	by vger.kernel.org with ESMTP id S261864AbVBAILJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 03:11:09 -0500
Subject: 2.6.10-as3
From: Andres Salomon <dilinger@voxel.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KGXNqNR0+qSQICdcwkGa"
Date: Tue, 01 Feb 2005 03:11:06 -0500
Message-Id: <1107245466.10362.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KGXNqNR0+qSQICdcwkGa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Here's 2.6.10-as3; it's way overdue.  Lots of alsa, usb, and ia64 fixes,
as well as numerous others all over the place. =20

The kernel patches can be grabbed from here:
http://www.acm.cs.rpi.edu/~dilinger/patches/2.6.10/as2/

07dc484313cd97dea357b988ba615994  ChangeLog
7457076a2c54af9f534ed053fb3e42de  linux-2.6.10-as3.tar.gz
87ce1ab9312837b4bb35d490abbfba7e  patch-2.6.10-as3.gz

Changes from 2.6.10-as2:

2005-02-01 07:48:41 GMT	Andres Salomon <dilinger@voxel.net>	patch-90

    Summary:
      tag 2.6.10-as3
    Revision:
      linux--dilinger--0--patch-90

   =20
   =20

    modified files:
     000-extraversion.patch


2005-02-01 06:45:20 GMT	Andres Salomon <dilinger@voxel.net>	patch-89

    Summary:
      087-ext3_graceful_corruption_fixes.patch
    Revision:
      linux--dilinger--0--patch-89

    [EXT3] This patch makes ext3 handle instances of corruption more gracef=
ully.
    It also changes __ext3_journal_forget (which 078-jbd_journal_revoke*.pa=
tch
    needs).
   =20
   =20

    new files:
     .arch-ids/087-ext3_graceful_corruption_fixes.patch.id
     087-ext3_graceful_corruption_fixes.patch


2005-01-31 05:35:48 GMT	Andres Salomon <dilinger@voxel.net>	patch-88

    Summary:
      086-i386_cpufreq_powernow_k8_acpi_error.patch
    Revision:
      linux--dilinger--0--patch-88

    [I386] If powernowk8_cpu_init() has a problem after it has initted acpi
    stuff, make sure to call the appropriate acpi exit routines before retu=
rning.
   =20
   =20

    new files:
     .arch-ids/086-i386_cpufreq_powernow_k8_acpi_error.patch.id
     086-i386_cpufreq_powernow_k8_acpi_error.patch


2005-01-31 05:21:23 GMT	Andres Salomon <dilinger@voxel.net>	patch-87

    Summary:
      085-ia64_irq_reg_typo.patch
    Revision:
      linux--dilinger--0--patch-87

    [IA64] Fix typo of register name; s/_IA64_REG_AR_SP/_IA64_REG_SP/.
   =20
   =20
   =20

    new files:
     .arch-ids/085-ia64_irq_reg_typo.patch.id
     085-ia64_irq_reg_typo.patch


2005-01-31 05:05:34 GMT	Andres Salomon <dilinger@voxel.net>	patch-86

    Summary:
      084-smp_nmi_watchdog_race.patch
    Revision:
      linux--dilinger--0--patch-86

    [I386/X86-64] Ensure that if a cpu takes too long to come up, the NMI
    watchdog check doesn't think it's having problems.
   =20
   =20

    new files:
     .arch-ids/084-smp_nmi_watchdog_race.patch.id
     084-smp_nmi_watchdog_race.patch


2005-01-31 04:56:59 GMT	Andres Salomon <dilinger@voxel.net>	patch-85

    Summary:
      083-x86_64_switch_mm_context_race.patch
    Revision:
      linux--dilinger--0--patch-85

    [X86-64] Fix race in x86-64 SMP TLB handling, when context switching.
   =20
   =20

    new files:
     .arch-ids/083-x86_64_switch_mm_context_race.patch.id
     083-x86_64_switch_mm_context_race.patch


2005-01-30 09:18:29 GMT	Andres Salomon <dilinger@voxel.net>	patch-84

    Summary:
      082-ide_it8172_init_return_failure.patch
    Revision:
      linux--dilinger--0--patch-84

    [IDE] it8172_init_one returns 1 instead of -ENODEV in probe function.  =
The
    pci subsystem considers that to be a success, when it should be a failu=
re.
   =20
   =20

    new files:
     .arch-ids/082-ide_it8172_init_return_failure.patch.id
     082-ide_it8172_init_return_failure.patch


2005-01-30 08:23:48 GMT	Andres Salomon <dilinger@voxel.net>	patch-83

    Summary:
      081-ia64_early_sn_setup_nested_loop.patch
    Revision:
      linux--dilinger--0--patch-83

    [IA64] early_sn_setup has a nested loop that uses the same loop variabl=
e
    as the outer loop.  This patch fixes that.
   =20
   =20

    new files:
     .arch-ids/081-ia64_early_sn_setup_nested_loop.patch.id
     081-ia64_early_sn_setup_nested_loop.patch


2005-01-30 06:18:34 GMT	Andres Salomon <dilinger@voxel.net>	patch-82

    Summary:
      080-kernel_sched_might_sleep_ignore_if_oopsed.patch
    Revision:
      linux--dilinger--0--patch-82

    Make __might_sleep() a no-op if the kernel has oopsed.
   =20
   =20

    new files:
     .arch-ids/080-kernel_sched_might_sleep_ignore_if_oopsed.patch.id
     080-kernel_sched_might_sleep_ignore_if_oopsed.patch


2005-01-30 06:14:48 GMT	Andres Salomon <dilinger@voxel.net>	patch-81

    Summary:
      079-i386_timer_resume_slowdown.patch
    Revision:
      linux--dilinger--0--patch-81

    [I386] After resume, make time run at normal speed.  Thanks to
    Daniel Drake <dsd@gentoo.org> for pointing this one out.
   =20
   =20

    new files:
     .arch-ids/079-i386_timer_resume_slowdown.patch.id
     079-i386_timer_resume_slowdown.patch


2005-01-30 05:43:06 GMT	Andres Salomon <dilinger@voxel.net>	patch-80

    Summary:
      078-jbd_journal_revoke_graceful_double_delete.patch
    Revision:
      linux--dilinger--0--patch-80

    [JBD] journal_revoke may try to delete a metadata block twice; this pat=
ch
    allows a graceful recovery, instead of a BUG().
   =20
   =20

    new files:
     .arch-ids/078-jbd_journal_revoke_graceful_double_delete.patch.id
     078-jbd_journal_revoke_graceful_double_delete.patch


2005-01-30 05:34:58 GMT	Andres Salomon <dilinger@voxel.net>	patch-79

    Summary:
      077-ext3_journal_abort_handle_silence.patch
    Revision:
      linux--dilinger--0--patch-79

    [EXT3] For aborted transaction, only spew errors the first time to avoi=
d
    a flood of errors.
   =20

    new files:
     .arch-ids/077-ext3_journal_abort_handle_silence.patch.id
     077-ext3_journal_abort_handle_silence.patch


2005-01-30 05:10:58 GMT	Andres Salomon <dilinger@voxel.net>	patch-78

    Summary:
      076-i2c_ali1563_devinit_fixes.patch
    Revision:
      linux--dilinger--0--patch-78

    Fix up probe and exit functions in i2c-ali1563 driver to use proper __d=
evinit
    and __devexit attribs.
   =20

    new files:
     .arch-ids/076-i2c_ali1563_devinit_fixes.patch.id
     076-i2c_ali1563_devinit_fixes.patch


2005-01-30 03:35:39 GMT	Andres Salomon <dilinger@voxel.net>	patch-77

    Summary:
      075-acpiphp_ibm_module_parm_perm.patch
    Revision:
      linux--dilinger--0--patch-77

    Fix permissions passed to module_param() in IBM pci hotplug driver.
   =20
   =20

    new files:
     .arch-ids/075-acpiphp_ibm_module_parm_perm.patch.id
     075-acpiphp_ibm_module_parm_perm.patch


2005-01-30 03:23:10 GMT	Andres Salomon <dilinger@voxel.net>	patch-76

    Summary:
      074-usb_makefile_fixes.patch
    Revision:
      linux--dilinger--0--patch-76

    [USB] Update makefile for sl811(-hcd) and dc2xx drivers.
   =20
   =20

    new files:
     .arch-ids/074-usb_makefile_fixes.patch.id
     074-usb_makefile_fixes.patch


2005-01-30 03:20:23 GMT	Andres Salomon <dilinger@voxel.net>	patch-75

    Summary:
      073-usb_gadget_serial_free_ports.patch
    Revision:
      linux--dilinger--0--patch-75

    [USB] Inside gs_free_ports: don't deref memory that's already been free=
d.
   =20
   =20

    new files:
     .arch-ids/073-usb_gadget_serial_free_ports.patch.id
     073-usb_gadget_serial_free_ports.patch


2005-01-30 03:12:33 GMT	Andres Salomon <dilinger@voxel.net>	patch-74

    Summary:
      072-sctp_do_bind_random_port.patch
    Revision:
      linux--dilinger--0--patch-74

    Fix bug within sctp_do_bind(); for ephemeral ports, set bp->port earlie=
r,
    so that addr actually gets the correct port (inside sctp_add_bind_addr)=
.
   =20

    new files:
     .arch-ids/072-sctp_do_bind_random_port.patch.id
     072-sctp_do_bind_random_port.patch


2005-01-30 02:57:58 GMT	Andres Salomon <dilinger@voxel.net>	patch-73

    Summary:
      071-alsa_creation_order_fixes.patch
    Revision:
      linux--dilinger--0--patch-73

    [ALSA] This fixes the creation order for a bunch of sound drivers.  Som=
e
    drivers were creating /proc entries and registering callback functions =
that
    required driver structs that had not yet been initialized.
   =20
   =20

    new files:
     .arch-ids/071-alsa_creation_order_fixes.patch.id
     071-alsa_creation_order_fixes.patch


2005-01-30 02:44:36 GMT	Andres Salomon <dilinger@voxel.net>	patch-72

    Summary:
      070-alsa_rme9652_hdsp_get_autosync.patch
    Revision:
      linux--dilinger--0--patch-72

    [ALSA] rme9652's snd_hdsp_get_autosync_ref() should be getting the valu=
e
    of hdsp_autosync_ref, not hdsp_pref_sync_ref.
   =20
   =20

    new files:
     .arch-ids/070-alsa_rme9652_hdsp_get_autosync.patch.id
     070-alsa_rme9652_hdsp_get_autosync.patch


2005-01-30 02:21:58 GMT	Andres Salomon <dilinger@voxel.net>	patch-71

    Summary:
      069-alsa_sscape_upload_firmware_len.patch
    Revision:
      linux--dilinger--0--patch-71

    [ALSA] This patch does two things; the first is a cleanup of calls to
    verify_area (replaced w/ access_oks) in the sscape driver that I was
    too lazy to strip out; the second is a fixup of the length handling
    of firmware in upload_dma_data.  If __copy_from_user fails to copy data=
,
    the number of failed bytes wasn't kept track of.
   =20

    new files:
     .arch-ids/069-alsa_sscape_upload_firmware_len.patch.id
     069-alsa_sscape_upload_firmware_len.patch


2005-01-30 01:59:47 GMT	Andres Salomon <dilinger@voxel.net>	patch-70

    Summary:
      068-scsi_sd_read_capacity_LBD_bail.patch
    Revision:
      linux--dilinger--0--patch-70

    For scsi disks, if the disk capacity is too large for what's configured
    in the kernel, don't even attempt to use the disk.
   =20

    new files:
     .arch-ids/068-scsi_sd_read_capacity_LBD_bail.patch.id
     068-scsi_sd_read_capacity_LBD_bail.patch


2005-01-30 01:09:31 GMT	Andres Salomon <dilinger@voxel.net>	patch-69

    Summary:
      067-scsi_gdth_pci_map_sg.patch
    Revision:
      linux--dilinger--0--patch-69

    In gdth driver, drop DMA/page mapping from gdth_copy_internal_data(); i=
t's unnecessary, and buggy.=20
   =20

    new files:
     .arch-ids/067-scsi_gdth_pci_map_sg.patch.id
     067-scsi_gdth_pci_map_sg.patch


2005-01-30 00:08:23 GMT	Andres Salomon <dilinger@voxel.net>	patch-68

    Summary:
      066-ibmvscsi_probe_delay_loop_fix.patch
    Revision:
      linux--dilinger--0--patch-68

    The ibmvscsi driver's probe function could potentially exit the delay l=
oop
    before the adapter has finished initializing (hostdata->request_limit =
=3D=3D 0),
    and thus end up not scanning for drives.
   =20

    new files:
     .arch-ids/066-ibmvscsi_probe_delay_loop_fix.patch.id
     066-ibmvscsi_probe_delay_loop_fix.patch


2005-01-27 07:06:37 GMT	Andres Salomon <dilinger@voxel.net>	patch-67

    Summary:
      065-alsa_vx_kcalloc.patch
    Revision:
      linux--dilinger--0--patch-67

    [ALSA] the vx driver allocates enough size for a pointer, when it shoul=
d
    be allocating enough size for a struct vx_core_t.
   =20
   =20

    new files:
     .arch-ids/065-alsa_vx_kcalloc.patch.id
     065-alsa_vx_kcalloc.patch


2005-01-27 07:03:58 GMT	Andres Salomon <dilinger@voxel.net>	patch-66

    Summary:
      064-alsa_usbaudio_disconnect.patch
    Revision:
      linux--dilinger--0--patch-66

    [ALSA] return -EBADFD when a usbaudio device is disconnected.
   =20
   =20

    new files:
     .arch-ids/064-alsa_usbaudio_disconnect.patch.id
     064-alsa_usbaudio_disconnect.patch


2005-01-27 07:01:41 GMT	Andres Salomon <dilinger@voxel.net>	patch-65

    Summary:
      063-alsa_opl4_build_fix.patch
    Revision:
      linux--dilinger--0--patch-65

    [ALSA] build snd-opl3-lib when SND_OPL4_LIB is enabled.
   =20
   =20

    new files:
     .arch-ids/063-alsa_opl4_build_fix.patch.id
     063-alsa_opl4_build_fix.patch


2005-01-27 06:47:48 GMT	Andres Salomon <dilinger@voxel.net>	patch-64

    Summary:
      062-alsa_sscape_user_copy_check.patch
    Revision:
      linux--dilinger--0--patch-64

    [ALSA] the sscape driver does a __copy_to_user without actually checkin=
g to
    see whether it succeeds.  This patch makes it check the result.
   =20
   =20

    new files:
     .arch-ids/062-alsa_sscape_user_copy_check.patch.id
     062-alsa_sscape_user_copy_check.patch


2005-01-27 06:45:52 GMT	Andres Salomon <dilinger@voxel.net>	patch-63

    Summary:
      061-alsa_es18xx_ifdef_typo.patch
    Revision:
      linux--dilinger--0--patch-63

    [ALSA] es18xx.c also has an ifdef typo; s/CONFIG_PNP_/CONFIG_PNP/.
   =20

    new files:
     .arch-ids/061-alsa_es18xx_ifdef_typo.patch.id
     061-alsa_es18xx_ifdef_typo.patch


2005-01-27 06:43:26 GMT	Andres Salomon <dilinger@voxel.net>	patch-62

    Summary:
      060-alsa_cs4231_lib_ifdef_typo.patch
    Revision:
      linux--dilinger--0--patch-62

    [ALSA] cs4231_lib.c has an #ifdef typo; s/SNDRV_DEBUGq_MCE/SNDRV_DEBUG_=
MCE/.
   =20

    new files:
     .arch-ids/060-alsa_cs4231_lib_ifdef_typo.patch.id
     060-alsa_cs4231_lib_ifdef_typo.patch


2005-01-27 06:39:19 GMT	Andres Salomon <dilinger@voxel.net>	patch-61

    Summary:
      059-ia64_unwind_stack_check.patch
    Revision:
      linux--dilinger--0--patch-61

    [IA64] Add a an additional sanity check to ia64's unw_unwind_to_user().
   =20
   =20

    new files:
     .arch-ids/059-ia64_unwind_stack_check.patch.id
     059-ia64_unwind_stack_check.patch


2005-01-27 06:35:54 GMT	Andres Salomon <dilinger@voxel.net>	patch-60

    Summary:
      058-ia64_binfmt_elf_bug_out.patch
    Revision:
      linux--dilinger--0--patch-60

    [IA64] Returning early from ia64_elf32_init in the case of failures
    could be problematic.  Instead of doing that, call BUG().
   =20
   =20

    new files:
     .arch-ids/058-ia64_binfmt_elf_bug_out.patch.id
     058-ia64_binfmt_elf_bug_out.patch


2005-01-27 06:31:58 GMT	Andres Salomon <dilinger@voxel.net>	patch-59

    Summary:
      057-scsi_ioctl_unknown_opcode.patch
    Revision:
      linux--dilinger--0--patch-59

    scsi_ioctl's verify_command() had a check added to print debugging info
    about unknown scsi opcodes; however, the check was incorrect.  This fix=
es
    it.
   =20
   =20

    new files:
     .arch-ids/057-scsi_ioctl_unknown_opcode.patch.id
     057-scsi_ioctl_unknown_opcode.patch


2005-01-22 10:11:06 GMT	Andres Salomon <dilinger@voxel.net>	patch-58

    Summary:
      056-x86_64_acpi_do_suspend_lowlevel_arg.patch
    Revision:
      linux--dilinger--0--patch-58

    [x86_64] ACPI's do_suspend_lowlevel for x86_64 was never updated to no =
longer
    take an argument.  This patch removes the test checking the (non-existe=
nt)
    arg.
   =20
   =20

    new files:
     .arch-ids/056-x86_64_acpi_do_suspend_lowlevel_arg.patch.id
     056-x86_64_acpi_do_suspend_lowlevel_arg.patch


2005-01-22 09:50:13 GMT	Andres Salomon <dilinger@voxel.net>	patch-57

    Summary:
      055-uml_new_thread_race.patch
    Revision:
      linux--dilinger--0--patch-57

    [UML] When creating a new thread, fix potential signal race that could
    cause stack corruption.
   =20

    new files:
     .arch-ids/055-uml_new_thread_race.patch.id
     055-uml_new_thread_race.patch


2005-01-22 09:34:18 GMT	Andres Salomon <dilinger@voxel.net>	patch-56

    Summary:
      054-ext3_journal_abort_before_panic.patch
    Revision:
      linux--dilinger--0--patch-56

    When an error occurs in ext3, if we're going to panic, do it *after* ab=
orting
    the journal.
   =20
   =20

    new files:
     .arch-ids/054-ext3_journal_abort_before_panic.patch.id
     054-ext3_journal_abort_before_panic.patch


2005-01-22 09:26:18 GMT	Andres Salomon <dilinger@voxel.net>	patch-55

    Summary:
      053-ipmi_unhandled_message_counting.patch
    Revision:
      linux--dilinger--0--patch-55

    This fixes some IPMI issues:
    - fix counting of handled and unhandled messages
    - decode_dmi should've been handling 16 byte boundaries instead of
      16 bit boundaries
   =20

    new files:
     .arch-ids/053-ipmi_unhandled_message_counting.patch.id
     053-ipmi_unhandled_message_counting.patch


2005-01-22 09:08:03 GMT	Andres Salomon <dilinger@voxel.net>	patch-54

    Summary:
      052-vfat_valid_longname_proper_return.patch
    Revision:
      linux--dilinger--0--patch-54

    Return proper error values from vfat_valid_longname(), and pass them ba=
ck
    to calling functions (vfat_mkdir, vfat_create).
   =20
   =20

    new files:
     .arch-ids/052-vfat_valid_longname_proper_return.patch.id
     052-vfat_valid_longname_proper_return.patch


2005-01-22 08:19:23 GMT	Andres Salomon <dilinger@voxel.net>	patch-53

    Summary:
      051-md_sync_page_io_max_vecs.patch
    Revision:
      linux--dilinger--0--patch-53

    Fix oops in md driver; when calling sync_page_io, correctly initialize
    a bio, ensuring bi_max_vecs is set.
   =20
   =20

    new files:
     .arch-ids/051-md_sync_page_io_max_vecs.patch.id
     051-md_sync_page_io_max_vecs.patch




--=20
Andres Salomon <dilinger@voxel.net>

--=-KGXNqNR0+qSQICdcwkGa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB/zma78o9R9NraMQRAtjIAJ0foQ3o1IPRrB7mveVMxxwbXBJeXgCfWOOf
hFzYhwkZBbM6WrKglQvcZ6s=
=LHCT
-----END PGP SIGNATURE-----

--=-KGXNqNR0+qSQICdcwkGa--

