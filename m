Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264706AbTBTClT>; Wed, 19 Feb 2003 21:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbTBTClT>; Wed, 19 Feb 2003 21:41:19 -0500
Received: from franka.aracnet.com ([216.99.193.44]:29061 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264706AbTBTClO>; Wed, 19 Feb 2003 21:41:14 -0500
Date: Wed, 19 Feb 2003 18:51:10 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 381] New: Lots of unresolved symbols (make modules_install/depmod) 
Message-ID: <2460000.1045709470@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please direct all replies to the submitter, not to me.

---------------------------------------

http://bugme.osdl.org/show_bug.cgi?id=381

           Summary: Lots of unresolved symbols (make modules_install/depmod)
    Kernel Version: 2.5.62
            Status: NEW
          Severity: blocking
             Owner: bugme-janitors@lists.osdl.org
         Submitter: Luke7Jr@yahoo.com


Hardware Environment: Described in detail in kernel config file
Software Environment: Glibc 2.3; GCC 3.2.1
Problem Description: Many depmod errors during make modules_install:
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.62; fi
depmod: *** Unresolved symbols in
/lib/modules/2.5.62/kernel/drivers/input/gameport/ns558.ko
depmod:         gameport_register_port
depmod:         gameport_unregister_port
depmod: *** Unresolved symbols in
/lib/modules/2.5.62/kernel/drivers/input/joystick/analog.ko
depmod:         gameport_open
depmod:         gameport_register_device
depmod:         gameport_unregister_device
depmod:         gameport_close
depmod: *** Unresolved symbols in
/lib/modules/2.5.62/kernel/drivers/net/tulip/tulip.ko
depmod:         crc32_le
depmod:         bitreverse
depmod: *** Unresolved symbols in
/lib/modules/2.5.62/kernel/drivers/usb/host/uhci-hcd.ko
depmod:         usb_claim_bandwidth
depmod:         usb_disabled
depmod:         usb_hcd_pci_resume
depmod:         usb_release_bandwidth
depmod:         usb_hcd_pci_probe
depmod:         usb_hcd_giveback_urb
depmod:         usb_check_bandwidth
depmod:         usb_register_root_hub
depmod:         usb_get_dev
depmod:         usb_connect
depmod:         usb_hcd_pci_remove
depmod:         usb_alloc_dev
depmod:         usb_hcd_pci_suspend
depmod:         usb_put_dev
depmod: *** Unresolved symbols in
/lib/modules/2.5.62/kernel/drivers/usb/storage/usb-storage.ko
depmod:         usb_sg_cancel
depmod:         usb_device_remove
depmod:         usb_deregister
depmod:         usb_sg_wait
depmod:         usb_free_urb
depmod:         usb_device_probe
depmod:         usb_alloc_urb
depmod:         usb_register
depmod:         usb_get_dev
depmod:         usb_reset_device
depmod:         usb_string
depmod:         usb_sg_init
depmod:         usb_submit_urb
depmod:         usb_control_msg
depmod:         usb_put_dev
depmod:         usb_clear_halt
depmod:         usb_unlink_urb
depmod: *** Unresolved symbols in
/lib/modules/2.5.62/kernel/drivers/video/tridentfb.ko
depmod:         cfb_copyarea
depmod:         cfb_imageblit
depmod:         cfb_fillrect
depmod: *** Unresolved symbols in /lib/modules/2.5.62/kernel/fs/cramfs/cramfs.ko
depmod:         zlib_inflate
depmod:         zlib_inflate_workspacesize
depmod:         zlib_inflateInit_
depmod:         zlib_inflateReset
depmod:         zlib_inflateEnd
depmod: *** Unresolved symbols in /lib/modules/2.5.62/kernel/fs/isofs/isofs.ko
depmod:         zlib_inflate
depmod:         zlib_inflate_workspacesize
depmod:         zlib_inflateInit_
depmod:         zlib_inflateEnd
depmod: *** Unresolved symbols in /lib/modules/2.5.62/kernel/fs/lockd/lockd.ko
depmod:         rpciod_up
depmod:         rpciod_down
depmod:         xdr_decode_string_inplace
depmod:         xdr_encode_string
depmod:         rpc_restart_call
depmod:         svc_exit_thread
depmod:         nlm_debug
depmod:         svc_wake_up
depmod:         svc_makesock
depmod:         svc_destroy
depmod:         rpc_create_client
depmod:         svc_create_thread
depmod:         rpc_call_async
depmod:         xdr_encode_netobj
depmod:         svc_recv
depmod:         svc_process
depmod:         rpc_delay
depmod:         rpc_destroy_client
depmod:         xdr_decode_netobj
depmod:         svc_create
depmod:         rpc_call_sync
depmod:         xprt_set_timeout
depmod:         xprt_destroy
depmod:         xprt_create_proto
depmod: *** Unresolved symbols in /lib/modules/2.5.62/kernel/fs/msdos/msdos.ko
depmod:         fat_scan
depmod:         fat_dir_empty
depmod:         fat_add_entries
depmod:         fat_notify_change
depmod:         fat_date_unix2dos
depmod:         fat_build_inode
depmod:         fat_detach
depmod:         fat_attach
depmod:         fat_new_dir
depmod:         fat_fill_super
depmod: *** Unresolved symbols in /lib/modules/2.5.62/kernel/fs/nfs/nfs.ko
depmod:         rpc_wake_up_task
depmod:         rpc_killall_tasks
depmod:         rpc_init_task
depmod:         xdr_encode_pages
depmod:         rpc_setbufsize
depmod:         nlmclnt_proc
depmod:         rpc_shutdown_client
depmod:         rpciod_up
depmod:         rpciod_down
depmod:         xdr_inline_pages
depmod:         lockd_down
depmod:         rpc_clnt_sigmask
depmod:         lockd_up
depmod:         rpc_proc_unregister
depmod:         xdr_encode_array
depmod:         nfs_debug
depmod:         rpc_create_client
depmod:         rpc_sleep_on
depmod:         rpcauth_lookupcred
depmod:         rpc_clnt_sigunmask
depmod:         rpc_call_setup
depmod:         rpc_call_sync
depmod:         put_rpccred
depmod:         xprt_destroy
depmod:         rpc_execute
depmod:         rpc_proc_register
depmod:         xdr_shift_buf
depmod:         xprt_create_proto
depmod: *** Unresolved symbols in /lib/modules/2.5.62/kernel/fs/vfat/vfat.ko
depmod:         fat_scan
depmod:         fat_dir_empty
depmod:         fat_add_entries
depmod:         fat__get_entry
depmod:         fat_notify_change
depmod:         fat_date_unix2dos
depmod:         fat_build_inode
depmod:         fat_search_long
depmod:         fat_detach
depmod:         fat_attach
depmod:         fat_new_dir
depmod:         fat_fill_super
depmod: *** Unresolved symbols in /lib/modules/2.5.62/kernel/net/ipv6/ipv6.ko
depmod:         xfrm6_unregister_type
depmod:         xfrm6_get_type
depmod:         xfrm6_register_type
depmod: *** Unresolved symbols in
/lib/modules/2.5.62/kernel/sound/core/seq/snd-seq-midi.ko
depmod:         snd_rawmidi_drain_output
depmod:         snd_rawmidi_kernel_release
depmod:         snd_rawmidi_info_select
depmod:         snd_rawmidi_kernel_read
depmod:         snd_rawmidi_output_params
depmod:         snd_rawmidi_kernel_open
depmod:         snd_rawmidi_input_params
depmod:         snd_rawmidi_kernel_write
depmod: *** Unresolved symbols in
/lib/modules/2.5.62/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko
depmod:         snd_rawmidi_transmit_peek
depmod:         snd_rawmidi_transmit_ack
depmod:         snd_rawmidi_receive
depmod:         snd_rawmidi_new
depmod:         snd_rawmidi_set_ops
depmod: *** Unresolved symbols in
/lib/modules/2.5.62/kernel/sound/drivers/opl3/snd-opl3-lib.ko
depmod:         snd_hwdep_new
depmod: *** Unresolved symbols in
/lib/modules/2.5.62/kernel/sound/drivers/opl3/snd-opl3-synth.ko
depmod:         snd_seq_instr_list_new
depmod:         snd_seq_instr_find
depmod:         snd_midi_channel_free_set
depmod:         snd_seq_instr_free_use
depmod:         snd_seq_instr_event
depmod:         snd_seq_instr_list_free
depmod:         snd_midi_channel_alloc_set
depmod:         snd_seq_fm_init
depmod:         snd_opl3_regmap
depmod:         snd_midi_process_event
depmod:         snd_opl3_reset
depmod: *** Unresolved symbols in
/lib/modules/2.5.62/kernel/sound/isa/sb/snd-sb16-dsp.ko
depmod:         snd_sbmixer_read
depmod:         snd_sbmixer_write
depmod:         snd_sbdsp_command
depmod: *** Unresolved symbols in
/lib/modules/2.5.62/kernel/sound/isa/sb/snd-sb16.ko
depmod:         snd_sb16dsp_pcm
depmod:         snd_sbmixer_read
depmod:         snd_opl3_hwdep_new
depmod:         snd_sb16dsp_configure
depmod:         snd_sbmixer_write
depmod:         snd_sbmixer_new
depmod:         snd_mpu401_uart_interrupt
depmod:         snd_sbdsp_create
depmod:         snd_sb16dsp_interrupt
depmod:         snd_opl3_create
depmod:         snd_mpu401_uart_new
depmod: *** Unresolved symbols in /lib/modules/2.5.62/kernel/sound/oss/sb.ko
depmod:         sb_dsp_init
depmod:         sb_dsp_detect
depmod:         sb_dsp_unload
depmod:         smw_free
depmod:         unload_sbmpu
depmod:         probe_sbmpu
depmod: *** Unresolved symbols in /lib/modules/2.5.62/kernel/sound/oss/sb_lib.ko
depmod:         sound_unload_mididev
depmod:         mixer_devs
depmod:         midi_synth_hw_control
depmod:         midi_synth_panning
depmod:         sound_alloc_mididev
depmod:         sound_alloc_mixerdev
depmod:         conf_printf
depmod:         midi_synth_ioctl
depmod:         midi_synth_start_note
depmod:         DMAbuf_outputintr
depmod:         probe_uart401
depmod:         midi_synth_kill_note
depmod:         sequencer_init
depmod:         midi_devs
depmod:         midi_synth_reset
depmod:         midi_synth_aftertouch
depmod:         sound_open_dma
depmod:         sound_unload_mixerdev
depmod:         midi_synth_close
depmod:         midi_synth_set_instr
depmod:         midi_synth_send_sysex
depmod:         uart401intr
depmod:         load_mixer_volumes
depmod:         unload_uart401
depmod:         audio_devs
depmod:         midi_synth_controller
depmod:         DMAbuf_inputintr
depmod:         sound_install_audiodrv
depmod:         sound_alloc_dma
depmod:         midi_synth_bender
depmod:         sound_free_dma
depmod:         midi_synth_open
depmod:         sound_close_dma
depmod:         sound_unload_audiodev
depmod:         midi_synth_setup_voice
depmod:         midi_synth_load_patch
depmod: *** Unresolved symbols in /lib/modules/2.5.62/kernel/sound/oss/uart401.ko
depmod:         sound_unload_mididev
depmod:         midi_synth_hw_control
depmod:         midi_synth_panning
depmod:         sound_alloc_mididev
depmod:         conf_printf
depmod:         midi_synth_ioctl
depmod:         midi_synth_start_note
depmod:         midi_synth_kill_note
depmod:         sequencer_init
depmod:         midi_devs
depmod:         midi_synth_reset
depmod:         midi_synth_aftertouch
depmod:         midi_synth_close
depmod:         midi_synth_set_instr
depmod:         midi_synth_send_sysex
depmod:         midi_synth_controller
depmod:         midi_synth_bender
depmod:         midi_synth_open
depmod:         midi_synth_setup_voice
depmod:         midi_synth_load_patch

Kernel config attached


