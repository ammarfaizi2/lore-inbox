Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbUANUPZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 15:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264310AbUANUPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 15:15:25 -0500
Received: from moraine.clusterfs.com ([66.246.132.190]:56025 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S264267AbUANUPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 15:15:19 -0500
Date: Wed, 14 Jan 2004 13:15:07 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: =?iso-8859-1?Q?J=FCrgen?= Scholz <juergen@scholz-gmbh.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hude read/write cache
Message-ID: <20040114201507.GE1964@schnapps.adilger.int>
Mail-Followup-To: =?iso-8859-1?Q?J=FCrgen?= Scholz <juergen@scholz-gmbh.cc>,
	linux-kernel@vger.kernel.org
References: <BC2B59C1.2E87%juergen@scholz-gmbh.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BC2B59C1.2E87%juergen@scholz-gmbh.cc>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 14, 2004  20:40 +0100, Jürgen Scholz wrote:
> I got a small server, which main purpose is routing and dialup besides being
> a repository for files. This system is very noisy. Because of that I want to
> stop the disks from spinning, when the system is in regular usage (standby,
> routing..). This should happen through a read and write cache which keeps
> the most often used files in RAM (like log files, bash, ...), so that there
> is no need for the system to access the (physical) hard drive.
> I would like to use a regular filesystem with a sort of transparent cache.
> Any ideas?

Look for the laptop-mode patches, they do exactly this.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

