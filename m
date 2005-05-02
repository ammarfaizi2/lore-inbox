Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVEBX4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVEBX4x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 19:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVEBX4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 19:56:53 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:13982 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261236AbVEBX4v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 19:56:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VKnhDArPCSE9FyUhBSqGChFJqMNiK9x4LTn1xeeTItYSL/Q6ZnsLc7kzFtw0zFXvmyOu/7UG97AxcPttufFTKsDEMPFjmLe27HXX47V/OoUSSxInlm65YAafpimv0rZMdPWpfFtQ0rDBvdcIJe0aMzezOB0n43uoCLtnc1fFRME=
Message-ID: <3f250c71050502165655f12110@mail.gmail.com>
Date: Mon, 2 May 2005 19:56:51 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc3-mm2: fs/proc/task_mmu.c warnings
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org
In-Reply-To: <20050502164501.50187481.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050430164303.6538f47c.akpm@osdl.org>
	 <20050501222916.GB3592@stusta.de>
	 <3f250c7105050215306de620ac@mail.gmail.com>
	 <3f250c7105050216357ae31105@mail.gmail.com>
	 <20050502164501.50187481.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 5/2/05, Andrew Morton <akpm@osdl.org> wrote:
> Mauricio Lin <mauriciolin@gmail.com> wrote:
> >
> > I managed to replicate the warning. This happens with the vanilla
> > kernel 2.6.11.8. Before this version this warning does not exist. The
> > last patch I posted was based on 2.6.11.7. I am going to post the new
> > patch asap.
> 
> Please don't generate patches for the mainline kernel against the -stable
> tree.  2.6.11.7 is ancient - we've added 22MB of diff since then.
> 
> I think I've fixed all the /proc/pid/smaps problems anwyay.

So you have fixed the warning message, right?

Do you mean that I do not have to create the patch for 2.6.11.8?

BR,

Mauricio Lin.
