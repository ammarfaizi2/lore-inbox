Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbVJLG0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbVJLG0M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 02:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbVJLG0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 02:26:12 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:41639 "HELO
	briare1.heliogroup.fr") by vger.kernel.org with SMTP
	id S1751333AbVJLG0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 02:26:11 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: linux-kernel@vger.kernel.org
Subject: Re: MPT fusion driver, better but still buggy at errors handling under 2.6
Date: Wed, 12 Oct 2005 06:22:06 GMT
Message-ID: <05EMF0V12@briare1.heliogroup.fr>
X-Mailer: Pliant 94
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Tonneau wrote:
>
>         also this is a remote server, and the
>         box did not came up after the remote sofware reboot request :-(

The Linux 2.6.13 MTP fusion driver has set the SCSI controler in a such a bad
state that it locked in it's own bios startup code as a result of the software
reboot request. A power cycle was required to reset everything properly.

