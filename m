Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWCTPwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWCTPwT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965568AbWCTPvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:51:44 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:55395 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965562AbWCTPvl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:51:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hz5VX+wZxKYEBJ/W+U+1SEwzz0d5vIL7Iqx9ptvIvnJMxtQeSdmexXBlImG3kyOsPDxs2A/MCMD4zosyF2gd2RANv6k/+sh0ORp6tfPAUoElo/watSAxYUeorrWP27tAkujWwFzCRd5hVfF6K6gYNz6GyOdLxVcJpsst8tdiVuA=
Message-ID: <84144f020603200751o22103ce1je1b1d4b3885a75a@mail.gmail.com>
Date: Mon, 20 Mar 2006 17:51:40 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Oliver Neukum" <neukum@fachschaft.cup.uni-muenchen.de>
Subject: Re: [PATCH]micro optimization of kcalloc
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0603201542250.17461@fachschaft.cup.uni-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0603201542250.17461@fachschaft.cup.uni-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/06, Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de> wrote:
> this optimises away a division in kcalloc by letting the compiler
> do it. It is redone to allow size==0.

Does this shrink kernel text and if yes, how much?

                                        Pekka
