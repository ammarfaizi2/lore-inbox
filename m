Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVJWOcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVJWOcY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 10:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVJWOcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 10:32:24 -0400
Received: from master.altlinux.ru ([62.118.250.235]:31495 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1750721AbVJWOcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 10:32:23 -0400
Date: Sun, 23 Oct 2005 18:31:20 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Sasa Ostrouska <sasa.ostrouska@volja.net>
Cc: Adam Kropelin <akropel1@rochester.rr.com>,
       Paolo Ornati <ornati@fastwebnet.it>, linux-kernel@vger.kernel.org
Subject: Re: oops in 2.6.14-rc3
Message-Id: <20051023183120.612240db.vsu@altlinux.ru>
In-Reply-To: <20051023102249.A18848@mail.kroptech.com>
References: <1130072744.7496.10.camel@localhost>
	<20051023102249.A18848@mail.kroptech.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__23_Oct_2005_18_31_20_+0400_MgJqUq4tTXv92cAm"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__23_Oct_2005_18_31_20_+0400_MgJqUq4tTXv92cAm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sun, 23 Oct 2005 10:22:49 -0400 Adam Kropelin wrote:

> Sasa Ostrouska <sasa.ostrouska@volja.net> wrote:
> > Oct 20 03:01:50 rc-vaio kernel: Unable to handle kernel paging request at virtual address f8e43706
> > Oct 20 03:01:50 rc-vaio kernel:  printing eip:
> > Oct 20 03:01:50 rc-vaio kernel: c01eaf49
> > Oct 20 03:01:50 rc-vaio kernel: *pde = 01bae067
> > Oct 20 03:01:50 rc-vaio kernel: Oops: 0000 [#1]
> > Oct 20 03:01:50 rc-vaio kernel: PREEMPT
> > Oct 20 03:01:50 rc-vaio kernel: Modules linked in: snd_pcm_oss
> > snd_mixer_oss lp ipv6 uhci_hcd joydev parport_pc parport psmouse pcspkr
> > rtc sis_agp shpchp pci_hotplug i2c_sis96x i2c_core usb_storage
> > snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd
> > snd_page_alloc ohci_hcd ehci_hcd usbcore sis900 ohci1394 ieee1394 tsdev
> > pcmcia firmware_class yenta_socket rsrc_nonstatic pcmcia_core ide_scsi
> > agpgart
> > Oct 20 03:01:50 rc-vaio kernel: CPU:    0
> > Oct 20 03:01:50 rc-vaio kernel: EIP:    0060:[<c01eaf49>]    Not tainted VLI
> > Oct 20 03:01:50 rc-vaio kernel: EFLAGS: 00010297   (2.6.14-rc4)
> > Oct 20 03:01:50 rc-vaio kernel: EIP is at vsnprintf+0x369/0x500
> > Oct 20 03:01:50 rc-vaio kernel: eax: f8e43706   ebx: 0000000a   ecx: f8e43706   edx: fffffffe
> > Oct 20 03:01:50 rc-vaio kernel: esi: f596e11f   edi: 00000000   ebp: f596efff   esp: f398ded0
> > Oct 20 03:01:50 rc-vaio kernel: ds: 007b   es: 007b   ss: 0068
> > Oct 20 03:01:50 rc-vaio kernel: Process grep (pid: 7529, threadinfo=f398c000 task=f6122030)
> > Oct 20 03:01:50 rc-vaio kernel: Stack: 000003e1 00000000 00000010 00000004 00000002 00000001 ffffffff ffffffff
> > Oct 20 03:01:50 rc-vaio kernel:        00000eed f596e113 c0331532 f596e113 f665c380 f665c380 00000113 c017c52f
> > Oct 20 03:01:50 rc-vaio kernel:        f398df44 c0330829 f7fe0ca0 c011fcb4 f665c380 c0331520 00000000 c0330829
> > Oct 20 03:01:50 rc-vaio kernel: Call Trace:
> > Oct 20 03:01:50 rc-vaio kernel:  [<c017c52f>] seq_printf+0x2f/0x60
> > Oct 20 03:01:50 rc-vaio kernel:  [<c011fcb4>] r_show+0x84/0x90
> > Oct 20 03:01:50 rc-vaio kernel:  [<c017c0f1>] seq_read+0x221/0x290
> > Oct 20 03:01:50 rc-vaio kernel:  [<c015bae7>] vfs_read+0xc7/0x180
> > Oct 20 03:01:50 rc-vaio kernel:  [<c015be77>] sys_read+0x47/0x80
> > Oct 20 03:01:50 rc-vaio kernel:  [<c0103005>] syscall_call+0x7/0xb
> > Oct 20 03:01:50 rc-vaio kernel: Code: 00 83 cf 01 89 44 24 1c eb bc 8b
> > 44 24 40 8b 54 24 18 83 44 24 40 04 8b 08 b8 fe 14 34 c0 81 f9 ff 0f 00
> > 00 0f 46 c8 89 c8 eb 06 <80> 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83
> > e7 10 89 c3 75 20
> > Oct 20 03:01:50 rc-vaio kernel:  <6>note: grep[7529] exited with preempt_count 1
> 
> If I had to guess (and I do) I'd say one of your shutdown scripts tried
> to grep thru something in /proc and the module that once supplied the
> data for that something is gone, without having removed its /proc
> entries. Lacking any particular insight on what module to blame, I'd
> start by disabling various modules and booting cleanly so they never
> load. Binary search your way thru them until you find the culprit.

$ git grep -w r_show    
fs/reiserfs/procfs.c:static int r_show(struct seq_file *m, void *v)
fs/reiserfs/procfs.c:   .show = r_show,
kernel/resource.c:static int r_show(struct seq_file *m, void *v)
kernel/resource.c:      .show   = r_show,

This does not look like r_show() from reiserfs, because that function
does not call seq_printf() directly, so it must be r_show() from
kernel/resource.c:

static int r_show(struct seq_file *m, void *v)
{
	struct resource *root = m->private;
	struct resource *r = v, *p;
	int width = root->end < 0x10000 ? 4 : 8;
	int depth;

	for (depth = 0, p = r; depth < MAX_IORES_LEVEL; depth++, p = p->parent)
		if (p->parent == root)
			break;
	seq_printf(m, "%*s%0*lx-%0*lx : %s\n",
			depth * 2, "",
			width, r->start,
			width, r->end,
			r->name ? r->name : "<BAD>");
	return 0;
}

This function is responsible for /proc/ioports and /proc/iomem.

First parameters of seq_printf() in the stack were:

	f665c380	m
	c0331520	"%*s%0*lx-%0*lx : %s\n"
	00000000	depth * 2
	c0330829	""

(unfortunately, no more information is available in the stack dump).

They do not look like the bad pointer (f8e43706), so the most likely
culprit is r->name - probably some module set the resource name to some
string constant, and then was unloaded, but did not perform the proper
cleanup.  And depth == 0 means that the problematic resource most likely
did not belong to a PCI device - maybe it was some legacy resource.

You have the list of modules which were loaded at oops time (see
"Modules linked in:" above); please also show the lsmod output obtained
when the system is working - then we can find which modules were
unloaded and investigate those more closely.

--Signature=_Sun__23_Oct_2005_18_31_20_+0400_MgJqUq4tTXv92cAm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDW568W82GfkQfsqIRAjAGAJwL67LF0Q6y0ZdUFwql+ZUTzIJbGgCeLUfP
3uBwkNfqYbp7UaUBwKwZIFM=
=BUel
-----END PGP SIGNATURE-----

--Signature=_Sun__23_Oct_2005_18_31_20_+0400_MgJqUq4tTXv92cAm--
