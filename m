Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbTARANU>; Fri, 17 Jan 2003 19:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbTARANU>; Fri, 17 Jan 2003 19:13:20 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:57074 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S261581AbTARANU>; Fri, 17 Jan 2003 19:13:20 -0500
Date: Fri, 17 Jan 2003 19:22:14 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.59 - usb-storage and sd-mod won't load
Message-ID: <20030118002214.GA1124@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


with usb-storage and sd-mod as modules, this appears in dmesg
amd the modules are not loaded:

usb_storage: Unknown symbol scsi_unregister_host
usb_storage: Unknown symbol scsi_register
usb_storage: Unknown symbol scsi_register_host
usb_storage: Unknown symbol scsi_sense_key_string
usb_storage: Unknown symbol scsi_extd_sense_format
sd_mod: Unknown symbol scsi_device_get
sd_mod: Unknown symbol scsi_wait_req
sd_mod: Unknown symbol scsi_register_device
sd_mod: Unknown symbol scsicam_bios_param
sd_mod: Unknown symbol scsi_block_when_processing_errors
sd_mod: Unknown symbol scsi_ioctl
sd_mod: Unknown symbol scsi_device_put
sd_mod: Unknown symbol scsi_unregister_device
sd_mod: Unknown symbol scsi_slave_detach
sd_mod: Unknown symbol scsi_release_request
sd_mod: Unknown symbol scsi_allocate_request
sd_mod: Unknown symbol scsi_slave_attach
sd_mod: Unknown symbol scsi_io_completion
sd_mod: Unknown symbol print_sense
sd_mod: Unknown symbol print_req_sense
sd_mod: Unknown symbol scsi_set_medium_removal

They load fine in 2.5.55/56/57/58

--  
Murray J. Root

