Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbVKWUbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbVKWUbF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVKWUbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:31:02 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:27340 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932447AbVKWUaj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:30:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZbIdPFxVMdvVXlRsG3+UjeCOOSr6M++1GQs05WRqTWCGKMt4VBoQhW1Iw66FKNrTAt6v2hdEDxwoWTVzZ5cVsWMy6NBmpRErC2pDzhgXu8WnMx9deqSudFV8xQhqCXvWDmwQPjZi33U4heBckwM6afDMHr6/5FoeOp+Y8MY0WzE=
Message-ID: <b1952ae90511231230j1121e7a0v501cf135761e154a@mail.gmail.com>
Date: Wed, 23 Nov 2005 21:30:38 +0100
From: =?ISO-8859-1?Q?Pelle_Lundstr=F6m?= <lunper@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: PROBLEM: No initialization of sound card
Cc: David Wragg <david@wragg.org>, linux-kernel@vger.kernel.org,
       ALSA user list <alsa-user@lists.sourceforge.net>
In-Reply-To: <1131841275.15223.17.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <m3veyxo8jb.fsf@dwragg.oilspace.com>
	 <1131841275.15223.17.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When running the commands "lsmod | grep ^snd | cut -d\  -f1 | xargs
rmmod" and then "modprobe snd_es18xx" then I get errors.

The dmesg output is:
: Unknown symbol snd_info_register
snd_timer: Unknown symbol snd_info_create_module_entry
snd_timer: Unknown symbol snd_info_free_entry
snd_timer: Unknown symbol snd_verbose_printk
snd_timer: Unknown symbol snd_iprintf
snd_timer: Unknown symbol snd_ecards_limit
snd_timer: Unknown symbol snd_oss_info_register
snd_timer: Unknown symbol snd_unregister_device
snd_timer: Unknown symbol snd_device_new
snd_timer: Unknown symbol snd_info_unregister
snd_timer: Unknown symbol snd_register_device
snd_opl3_lib: Unknown symbol snd_verbose_printd
snd_opl3_lib: Unknown symbol snd_seq_device_new
snd_opl3_lib: Unknown symbol snd_timer_interrupt
snd_opl3_lib: Unknown symbol snd_verbose_printk
snd_opl3_lib: Unknown symbol snd_hwdep_new
snd_opl3_lib: Unknown symbol snd_timer_new
snd_opl3_lib: Unknown symbol snd_device_new
snd_opl3_lib: Unknown symbol snd_device_free
snd_pcm: Unknown symbol snd_verbose_printd
snd_pcm: Unknown symbol snd_info_register
snd_pcm: Unknown symbol snd_info_create_module_entry
snd_pcm: Unknown symbol snd_timer_notify
snd_pcm: Unknown symbol snd_timer_interrupt
snd_pcm: Unknown symbol snd_info_free_entry
snd_pcm: Unknown symbol snd_info_get_str
snd_pcm: Unknown symbol snd_verbose_printk
snd_pcm: Unknown symbol snd_ctl_register_ioctl
snd_pcm: Unknown symbol snd_card_file_add
snd_pcm: Unknown symbol snd_iprintf
snd_pcm: Unknown symbol snd_major
snd_pcm: Unknown symbol snd_unregister_device
snd_pcm: Unknown symbol snd_timer_new
snd_pcm: Unknown symbol snd_device_new
snd_pcm: Unknown symbol snd_ctl_unregister_ioctl
snd_pcm: Unknown symbol snd_info_create_card_entry
snd_pcm: Unknown symbol snd_power_wait
snd_pcm: Unknown symbol snd_device_free
snd_pcm: Unknown symbol snd_card_file_remove
snd_pcm: Unknown symbol snd_info_unregister
snd_pcm: Unknown symbol snd_device_register
snd_pcm: Unknown symbol snd_register_device
snd_pcm: Unknown symbol snd_info_get_line
snd_es18xx: Unknown symbol snd_verbose_printd
snd_es18xx: Unknown symbol snd_ctl_add
snd_es18xx: Unknown symbol snd_pcm_new
snd_es18xx: Unknown symbol snd_card_register
snd_es18xx: Unknown symbol snd_card_free
snd_es18xx: Unknown symbol snd_pcm_lib_preallocate_pages_for_all
snd_es18xx: Unknown symbol snd_pcm_format_unsigned
snd_es18xx: Unknown symbol snd_opl3_create
snd_es18xx: Unknown symbol snd_verbose_printk
snd_es18xx: Unknown symbol snd_dma_pointer
snd_es18xx: Unknown symbol snd_ctl_new1
snd_es18xx: Unknown symbol snd_card_new
snd_es18xx: Unknown symbol snd_pcm_lib_malloc_pages
snd_es18xx: Unknown symbol snd_pcm_lib_ioctl
snd_es18xx: Unknown symbol snd_pcm_lib_free_pages
snd_es18xx: Unknown symbol snd_card_set_generic_pm_callback
snd_es18xx: Unknown symbol snd_ctl_notify
snd_es18xx: Unknown symbol snd_pcm_set_ops
snd_es18xx: Unknown symbol snd_device_new
snd_es18xx: Unknown symbol snd_mpu401_uart_interrupt
snd_es18xx: Unknown symbol snd_pcm_suspend_all
snd_es18xx: Unknown symbol snd_card_set_generic_dev
snd_es18xx: Unknown symbol snd_card_disconnect
snd_es18xx: Unknown symbol _snd_pcm_hw_param_setempty
snd_es18xx: Unknown symbol snd_mpu401_uart_new
snd_es18xx: Unknown symbol snd_card_free_in_thread
snd_es18xx: Unknown symbol snd_pcm_lib_preallocate_free_for_all
snd_es18xx: Unknown symbol snd_opl3_hwdep_new
snd_es18xx: Unknown symbol snd_pcm_hw_constraint_ratnums
snd_es18xx: Unknown symbol snd_pcm_period_elapsed
snd_es18xx: Unknown symbol snd_dma_program
snd_es18xx: Unknown symbol snd_pcm_format_width
input: PC Speaker
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
snd: Unknown parameter `device_mode'
snd_seq_device: Unknown symbol snd_info_register
snd_seq_device: Unknown symbol snd_info_create_module_entry
snd_seq_device: Unknown symbol snd_info_free_entry
snd_seq_device: Unknown symbol snd_seq_root
snd_seq_device: Unknown symbol snd_verbose_printk
snd_seq_device: Unknown symbol snd_iprintf
snd_seq_device: Unknown symbol snd_device_new
snd_seq_device: Unknown symbol snd_info_unregister
snd_rawmidi: Unknown symbol snd_verbose_printd
snd_rawmidi: Unknown symbol snd_info_register
snd_rawmidi: Unknown symbol snd_seq_device_new
snd_rawmidi: Unknown symbol snd_info_free_entry
snd_rawmidi: Unknown symbol snd_unregister_oss_device
snd_rawmidi: Unknown symbol snd_verbose_printk
snd_rawmidi: Unknown symbol snd_register_oss_device
snd_rawmidi: Unknown symbol snd_ctl_register_ioctl
snd_rawmidi: Unknown symbol snd_card_file_add
snd_rawmidi: Unknown symbol snd_iprintf
snd_rawmidi: Unknown symbol snd_oss_info_register
snd_rawmidi: Unknown symbol snd_unregister_device
snd_rawmidi: Unknown symbol snd_device_new
snd_rawmidi: Unknown symbol snd_ctl_unregister_ioctl
snd_rawmidi: Unknown symbol snd_info_create_card_entry
snd_rawmidi: Unknown symbol snd_device_free
snd_rawmidi: Unknown symbol snd_card_file_remove
snd_rawmidi: Unknown symbol snd_info_unregister
snd_rawmidi: Unknown symbol snd_device_register
snd_rawmidi: Unknown symbol snd_register_device
snd_mpu401_uart: Unknown symbol snd_rawmidi_receive
snd_mpu401_uart: Unknown symbol snd_verbose_printk
snd_mpu401_uart: Unknown symbol snd_rawmidi_transmit_ack
snd_mpu401_uart: Unknown symbol snd_rawmidi_transmit_peek
snd_mpu401_uart: Unknown symbol snd_rawmidi_new
snd_mpu401_uart: Unknown symbol snd_rawmidi_set_ops
snd_mpu401_uart: Unknown symbol snd_device_free
snd_hwdep: Unknown symbol snd_info_register
snd_hwdep: Unknown symbol snd_info_create_module_entry
snd_hwdep: Unknown symbol snd_info_free_entry
snd_hwdep: Unknown symbol snd_unregister_oss_device
snd_hwdep: Unknown symbol snd_verbose_printk
snd_hwdep: Unknown symbol snd_register_oss_device
snd_hwdep: Unknown symbol snd_ctl_register_ioctl
snd_hwdep: Unknown symbol snd_card_file_add
snd_hwdep: Unknown symbol snd_iprintf
snd_hwdep: Unknown symbol snd_unregister_device
snd_hwdep: Unknown symbol snd_device_new
snd_hwdep: Unknown symbol snd_ctl_unregister_ioctl
snd_hwdep: Unknown symbol snd_card_file_remove
snd_hwdep: Unknown symbol snd_info_unregister
snd_hwdep: Unknown symbol snd_register_device
snd_timer: Unknown symbol snd_verbose_printd
snd_timer: Unknown symbol snd_info_register
snd_timer: Unknown symbol snd_info_create_module_entry
snd_timer: Unknown symbol snd_info_free_entry
snd_timer: Unknown symbol snd_verbose_printk
snd_timer: Unknown symbol snd_iprintf
snd_timer: Unknown symbol snd_ecards_limit
snd_timer: Unknown symbol snd_oss_info_register
snd_timer: Unknown symbol snd_unregister_device
snd_timer: Unknown symbol snd_device_new
snd_timer: Unknown symbol snd_info_unregister
snd_timer: Unknown symbol snd_register_device
snd_opl3_lib: Unknown symbol snd_verbose_printd
snd_opl3_lib: Unknown symbol snd_seq_device_new
snd_opl3_lib: Unknown symbol snd_timer_interrupt
snd_opl3_lib: Unknown symbol snd_verbose_printk
snd_opl3_lib: Unknown symbol snd_hwdep_new
snd_opl3_lib: Unknown symbol snd_timer_new
snd_opl3_lib: Unknown symbol snd_device_new
snd_opl3_lib: Unknown symbol snd_device_free
snd_pcm: Unknown symbol snd_verbose_printd
snd_pcm: Unknown symbol snd_info_register
snd_pcm: Unknown symbol snd_info_create_module_entry
snd_pcm: Unknown symbol snd_timer_notify
snd_pcm: Unknown symbol snd_timer_interrupt
snd_pcm: Unknown symbol snd_info_free_entry
snd_pcm: Unknown symbol snd_info_get_str
snd_pcm: Unknown symbol snd_verbose_printk
snd_pcm: Unknown symbol snd_ctl_register_ioctl
snd_pcm: Unknown symbol snd_card_file_add
snd_pcm: Unknown symbol snd_iprintf
snd_pcm: Unknown symbol snd_major
snd_pcm: Unknown symbol snd_unregister_device
snd_pcm: Unknown symbol snd_timer_new
snd_pcm: Unknown symbol snd_device_new
snd_pcm: Unknown symbol snd_ctl_unregister_ioctl
snd_pcm: Unknown symbol snd_info_create_card_entry
snd_pcm: Unknown symbol snd_power_wait
snd_pcm: Unknown symbol snd_device_free
snd_pcm: Unknown symbol snd_card_file_remove
snd_pcm: Unknown symbol snd_info_unregister
snd_pcm: Unknown symbol snd_device_register
snd_pcm: Unknown symbol snd_register_device
snd_pcm: Unknown symbol snd_info_get_line
snd_es18xx: Unknown symbol snd_verbose_printd
snd_es18xx: Unknown symbol snd_ctl_add
snd_es18xx: Unknown symbol snd_pcm_new
snd_es18xx: Unknown symbol snd_card_register
snd_es18xx: Unknown symbol snd_card_free
snd_es18xx: Unknown symbol snd_pcm_lib_preallocate_pages_for_all
snd_es18xx: Unknown symbol snd_pcm_format_unsigned
snd_es18xx: Unknown symbol snd_opl3_create
snd_es18xx: Unknown symbol snd_verbose_printk
snd_es18xx: Unknown symbol snd_dma_pointer
snd_es18xx: Unknown symbol snd_ctl_new1
snd_es18xx: Unknown symbol snd_card_new
snd_es18xx: Unknown symbol snd_pcm_lib_malloc_pages
snd_es18xx: Unknown symbol snd_pcm_lib_ioctl
snd_es18xx: Unknown symbol snd_pcm_lib_free_pages
snd_es18xx: Unknown symbol snd_card_set_generic_pm_callback
snd_es18xx: Unknown symbol snd_ctl_notify
snd_es18xx: Unknown symbol snd_pcm_set_ops
snd_es18xx: Unknown symbol snd_device_new
snd_es18xx: Unknown symbol snd_mpu401_uart_interrupt
snd_es18xx: Unknown symbol snd_pcm_suspend_all
snd_es18xx: Unknown symbol snd_card_set_generic_dev
snd_es18xx: Unknown symbol snd_card_disconnect
snd_es18xx: Unknown symbol _snd_pcm_hw_param_setempty
snd_es18xx: Unknown symbol snd_mpu401_uart_new
snd_es18xx: Unknown symbol snd_card_free_in_thread
snd_es18xx: Unknown symbol snd_pcm_lib_preallocate_free_for_all
snd_es18xx: Unknown symbol snd_opl3_hwdep_new
snd_es18xx: Unknown symbol snd_pcm_hw_constraint_ratnums
snd_es18xx: Unknown symbol snd_pcm_period_elapsed
snd_es18xx: Unknown symbol snd_dma_program
snd_es18xx: Unknown symbol snd_pcm_format_width
snd: Unknown parameter `device_mode'
snd_seq_device: Unknown symbol snd_info_register
snd_seq_device: Unknown symbol snd_info_create_module_entry
snd_seq_device: Unknown symbol snd_info_free_entry
snd_seq_device: Unknown symbol snd_seq_root
snd_seq_device: Unknown symbol snd_verbose_printk
snd_seq_device: Unknown symbol snd_iprintf
snd_seq_device: Unknown symbol snd_device_new
snd_seq_device: Unknown symbol snd_info_unregister
snd_rawmidi: Unknown symbol snd_verbose_printd
snd_rawmidi: Unknown symbol snd_info_register
snd_rawmidi: Unknown symbol snd_seq_device_new
snd_rawmidi: Unknown symbol snd_info_free_entry
snd_rawmidi: Unknown symbol snd_unregister_oss_device
snd_rawmidi: Unknown symbol snd_verbose_printk
snd_rawmidi: Unknown symbol snd_register_oss_device
snd_rawmidi: Unknown symbol snd_ctl_register_ioctl
snd_rawmidi: Unknown symbol snd_card_file_add
snd_rawmidi: Unknown symbol snd_iprintf
snd_rawmidi: Unknown symbol snd_oss_info_register
snd_rawmidi: Unknown symbol snd_unregister_device
snd_rawmidi: Unknown symbol snd_device_new
snd_rawmidi: Unknown symbol snd_ctl_unregister_ioctl
snd_rawmidi: Unknown symbol snd_info_create_card_entry
snd_rawmidi: Unknown symbol snd_device_free
snd_rawmidi: Unknown symbol snd_card_file_remove
snd_rawmidi: Unknown symbol snd_info_unregister
snd_rawmidi: Unknown symbol snd_device_register
snd_rawmidi: Unknown symbol snd_register_device
snd_mpu401_uart: Unknown symbol snd_rawmidi_receive
snd_mpu401_uart: Unknown symbol snd_verbose_printk
snd_mpu401_uart: Unknown symbol snd_rawmidi_transmit_ack
snd_mpu401_uart: Unknown symbol snd_rawmidi_transmit_peek
snd_mpu401_uart: Unknown symbol snd_rawmidi_new
snd_mpu401_uart: Unknown symbol snd_rawmidi_set_ops
snd_mpu401_uart: Unknown symbol snd_device_free
snd_hwdep: Unknown symbol snd_info_register
snd_hwdep: Unknown symbol snd_info_create_module_entry
snd_hwdep: Unknown symbol snd_info_free_entry
snd_hwdep: Unknown symbol snd_unregister_oss_device
snd_hwdep: Unknown symbol snd_verbose_printk
snd_hwdep: Unknown symbol snd_register_oss_device
snd_hwdep: Unknown symbol snd_ctl_register_ioctl
snd_hwdep: Unknown symbol snd_card_file_add
snd_hwdep: Unknown symbol snd_iprintf
snd_hwdep: Unknown symbol snd_unregister_device
snd_hwdep: Unknown symbol snd_device_new
snd_hwdep: Unknown symbol snd_ctl_unregister_ioctl
snd_hwdep: Unknown symbol snd_card_file_remove
snd_hwdep: Unknown symbol snd_info_unregister
snd_hwdep: Unknown symbol snd_register_device
snd_timer: Unknown symbol snd_verbose_printd
snd_timer: Unknown symbol snd_info_register
snd_timer: Unknown symbol snd_info_create_module_entry
snd_timer: Unknown symbol snd_info_free_entry
snd_timer: Unknown symbol snd_verbose_printk
snd_timer: Unknown symbol snd_iprintf
snd_timer: Unknown symbol snd_ecards_limit
snd_timer: Unknown symbol snd_oss_info_register
snd_timer: Unknown symbol snd_unregister_device
snd_timer: Unknown symbol snd_device_new
snd_timer: Unknown symbol snd_info_unregister
snd_timer: Unknown symbol snd_register_device
snd_opl3_lib: Unknown symbol snd_verbose_printd
snd_opl3_lib: Unknown symbol snd_seq_device_new
snd_opl3_lib: Unknown symbol snd_timer_interrupt
snd_opl3_lib: Unknown symbol snd_verbose_printk
snd_opl3_lib: Unknown symbol snd_hwdep_new
snd_opl3_lib: Unknown symbol snd_timer_new
snd_opl3_lib: Unknown symbol snd_device_new
snd_opl3_lib: Unknown symbol snd_device_free
snd_pcm: Unknown symbol snd_verbose_printd
snd_pcm: Unknown symbol snd_info_register
snd_pcm: Unknown symbol snd_info_create_module_entry
snd_pcm: Unknown symbol snd_timer_notify
snd_pcm: Unknown symbol snd_timer_interrupt
snd_pcm: Unknown symbol snd_info_free_entry
snd_pcm: Unknown symbol snd_info_get_str
snd_pcm: Unknown symbol snd_verbose_printk
snd_pcm: Unknown symbol snd_ctl_register_ioctl
snd_pcm: Unknown symbol snd_card_file_add
snd_pcm: Unknown symbol snd_iprintf
snd_pcm: Unknown symbol snd_major
snd_pcm: Unknown symbol snd_unregister_device
snd_pcm: Unknown symbol snd_timer_new
snd_pcm: Unknown symbol snd_device_new
snd_pcm: Unknown symbol snd_ctl_unregister_ioctl
snd_pcm: Unknown symbol snd_info_create_card_entry
snd_pcm: Unknown symbol snd_power_wait
snd_pcm: Unknown symbol snd_device_free
snd_pcm: Unknown symbol snd_card_file_remove
snd_pcm: Unknown symbol snd_info_unregister
snd_pcm: Unknown symbol snd_device_register
snd_pcm: Unknown symbol snd_register_device
snd_pcm: Unknown symbol snd_info_get_line
snd_es18xx: Unknown symbol snd_verbose_printd
snd_es18xx: Unknown symbol snd_ctl_add
snd_es18xx: Unknown symbol snd_pcm_new
snd_es18xx: Unknown symbol snd_card_register
snd_es18xx: Unknown symbol snd_card_free
snd_es18xx: Unknown symbol snd_pcm_lib_preallocate_pages_for_all
snd_es18xx: Unknown symbol snd_pcm_format_unsigned
snd_es18xx: Unknown symbol snd_opl3_create
snd_es18xx: Unknown symbol snd_verbose_printk
snd_es18xx: Unknown symbol snd_dma_pointer
snd_es18xx: Unknown symbol snd_ctl_new1
snd_es18xx: Unknown symbol snd_card_new
snd_es18xx: Unknown symbol snd_pcm_lib_malloc_pages
snd_es18xx: Unknown symbol snd_pcm_lib_ioctl
snd_es18xx: Unknown symbol snd_pcm_lib_free_pages
snd_es18xx: Unknown symbol snd_card_set_generic_pm_callback
snd_es18xx: Unknown symbol snd_ctl_notify
snd_es18xx: Unknown symbol snd_pcm_set_ops
snd_es18xx: Unknown symbol snd_device_new
snd_es18xx: Unknown symbol snd_mpu401_uart_interrupt
snd_es18xx: Unknown symbol snd_pcm_suspend_all
snd_es18xx: Unknown symbol snd_card_set_generic_dev
snd_es18xx: Unknown symbol snd_card_disconnect
snd_es18xx: Unknown symbol _snd_pcm_hw_param_setempty
snd_es18xx: Unknown symbol snd_mpu401_uart_new
snd_es18xx: Unknown symbol snd_card_free_in_thread
snd_es18xx: Unknown symbol snd_pcm_lib_preallocate_free_for_all
snd_es18xx: Unknown symbol snd_opl3_hwdep_new
snd_es18xx: Unknown symbol snd_pcm_hw_constraint_ratnums
snd_es18xx: Unknown symbol snd_pcm_period_elapsed
snd_es18xx: Unknown symbol snd_dma_program
snd_es18xx: Unknown symbol snd_pcm_format_width

Regards
   //Pelle

On 11/13/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Sat, 2005-11-12 at 21:34 +0000, David Wragg wrote:
> > On Sat, 2005-11-12 at 21:43 +0100, Pelle Lundström wrote:
> > > 1. Kernel 2.6.14.2 fails to locate and initiate sound card.
> >
> > I have seen similar problems due to trailing spaces on option lines in
> > /etc/modprobe.com.  These get interpreted by the kernel as zero-length
> > options, causing similar "unknown parameter" errors. So check that
> > file, and remove any suspicious spaces at the ends of lines.
>
> Run "lsmod | grep ^snd | cut -d\  -f1 | xargs rmmod" then modprobe
> snd_es18xx from the command line, then send the output of dmesg if it
> does not work.
>
> FYI, please cc: alsa-user at lists.sourceforge.net with any future ALSA
> bug reports (alsa-devel if you have a patch).
>
> Lee
