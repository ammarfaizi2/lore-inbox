Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310666AbSDXJcH>; Wed, 24 Apr 2002 05:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310749AbSDXJcG>; Wed, 24 Apr 2002 05:32:06 -0400
Received: from dsl-213-023-038-128.arcor-ip.net ([213.23.38.128]:62890 "EHLO
	starship") by vger.kernel.org with ESMTP id <S310666AbSDXJcF>;
	Wed, 24 Apr 2002 05:32:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Luigi Genoni <kernel@Expansa.sns.it>, m.knoblauch@TeraPort.de
Subject: Re: XFS in the main kernel
Date: Tue, 23 Apr 2002 11:32:40 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0204232330430.4925-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16zwfB-0002Mr-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 April 2002 23:43, Luigi Genoni wrote:
> If I do remember well a strong obiection to XFS is that it introduces a
> kernel thread to emulate Irix behavious to talk with pagebuf (a la Irix),
> end to have an interface with VM and Block Device layer.

There is nothing wrong with a filesystem having its own management thread -
this seems to be a feature of all the new filesystems.  How that thread
interacts with vm and the vfs is an open question, not answered very well
by any filesystem at the moment, let alone XFS.  Bottom line: XFS's thread
is not the issue.

-- 
Daniel
