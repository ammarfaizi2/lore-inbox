Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWBBRR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWBBRR4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 12:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWBBRR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 12:17:56 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:54284 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932182AbWBBRRz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 12:17:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UCqBincN0ZPFts6mHAXqIQ41le4SYTjDADgRWCKhR+VKcTofoR+7Gh/4mHXWEA0wyWa8WS3eoxtZ5hptF4FVZ5HDddVX5XA3/fFBNwCBdOjxFKgmt28cRRQQ/U8wTWt1TbDSLJ0MjeYmm+J+M/lb+VPw4/aRyhWAbLXKPIiqtTc=
Message-ID: <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com>
Date: Thu, 2 Feb 2006 12:17:53 -0500
From: Albert Cahalan <acahalan@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>, mrmacman_g4@mac.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <20060202161853.GB8833@voodoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43D7B1E7.nailDFJ9MUZ5G@burner> <43D8C04F.nailE1C2X9KNC@burner>
	 <43DDFBFF.nail16Z3N3C0M@burner>
	 <1138642683.7404.31.camel@juerg-pd.bitron.ch>
	 <43DF3C3A.nail2RF112LAB@burner>
	 <1138710764.17338.47.camel@juerg-t40p.bitron.ch>
	 <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail>
	 <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/06, Jim Crilly <jim@why.dont.jablowme.net> wrote:
> On 02/02/06 12:17:09PM +0100, Joerg Schilling wrote:
> > Jim Crilly <jim@why.dont.jablowme.net> wrote:
> >
> > > Every other method to access those devices uses the device name, i.e.
> > > mount, fsck, etc, so why should cdrecord be different?
> >
> > inadequateness on Linux did force libscg to go this way.
> >
>
> And inadequacies are what's causing libscg and 'cdrecord -scanbus' to fail
> to list all IDE devices on Linux. Unless the comments about it stopping the
> scan after getting -EPERM on one device are wrong.

I'm seeing even worse behavior. Since /dev/hda is a disk with mounted
filesystems, my kernel refuses access even for root. Thus, even root
is unable to scan the /dev/hd* devices!
