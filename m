Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267404AbUJRVYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267404AbUJRVYl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 17:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267502AbUJRVYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 17:24:40 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:29891 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267404AbUJRVUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 17:20:36 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=BTHiyGWZAi/rwBOd7MVmAfwaXlDrwc/1ssrD8RgrF7XbrYKoczUHvNiU3vCH9GViTqbOVdoRk1kVIFijr2pMUG9VY4WqECJ76kFLH3axE90LqOuMgUo9BYDzA+pn10Ao8PZRmFx5nbcmD9cDD0HMmlDbvLtxBHngVy4yAuUrDxI
Message-ID: <8783be660410181420683d1341@mail.gmail.com>
Date: Mon, 18 Oct 2004 17:20:34 -0400
From: Ross Biro <ross.biro@gmail.com>
Reply-To: Ross Biro <ross.biro@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Dma problems with Promise IDE controller
Cc: Johan Groth <jgroth@dsl.pipex.com>, linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e04101813221d36b793@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41741CDB.5010300@dsl.pipex.com>
	 <58cb370e04101813221d36b793@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004 22:22:38 +0200, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> On Mon, 18 Oct 2004 20:43:23 +0100, Johan Groth <jgroth@dsl.pipex.com> wrote:
> > Oct 18 18:03:16 lion kernel: hdg: dma timeout retry: error=0x40 {
> > UncorrectableError }, LBAsect=53500655, sector=53500520

The Uncorrectable Error is a dead give away.  You have a bad sector on
your drive.
