Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266006AbUHHRbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbUHHRbo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 13:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266014AbUHHRbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 13:31:44 -0400
Received: from vivaldi.madbase.net ([81.173.6.10]:5841 "HELO
	vivaldi.madbase.net") by vger.kernel.org with SMTP id S266006AbUHHRbn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 13:31:43 -0400
Date: Sun, 8 Aug 2004 13:31:41 -0400 (EDT)
From: Eric Lammerts <eric@lammerts.org>
X-X-Sender: eric@vivaldi.madbase.net
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: axboe@suse.de, James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
In-Reply-To: <200408061330.i76DU2Tm005937@burner.fokus.fraunhofer.de>
Message-ID: <Pine.LNX.4.58.0408081306440.8756@vivaldi.madbase.net>
References: <200408061330.i76DU2Tm005937@burner.fokus.fraunhofer.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 6 Aug 2004, Joerg Schilling wrote:
> The CAM interface (which is from the SCSI standards group)
> usually is implemeted in a way that applications open /dev/cam and
> later supply bus, target and lun in order to get connected
> to any device on the system that talks SCSI.
>
> Let me repeat: If you believe that this is a bad idea, give very
> good reasons.

With this interface, how do you grant non-root users access to a CD
writer, but prevent them from directly accessing a SCSI harddisk?

Eric
