Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbVCIKWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbVCIKWe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 05:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbVCIKWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 05:22:34 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:57323 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262238AbVCIKW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 05:22:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=bCi1h4Kqug6DrD7CuAca8RMz1kIC48yAghNF+LnIe1rmZYDiA/2qAQAcWXzDMqdtJSh+iaLGuqI7epiVjMcltXepO7diZF5Ymw/5ZVvLmLRC6NJVSYDiyIuuxCpuRdQ7LgqZXhSi6IJgaeSqdNAit+DzSKVD1HFpDAofpKehPqA=
Message-ID: <84144f0205030902224a3a87ab@mail.gmail.com>
Date: Wed, 9 Mar 2005 12:22:28 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] VGA arbitration: draft of kernel side
Cc: Kronos <kronos@kronoz.cjb.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       penberg@cs.helsinki.fi
In-Reply-To: <1110321980.13607.294.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050308212909.GA18376@dreamland.darkstar.lan>
	 <1110321980.13607.294.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Tue, 2005-03-08 at 22:29 +0100, Kronos wrote:
> > kfree(NULL) is fine, no need to check for null pointer.

On Wed, 09 Mar 2005 09:46:20 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Hehe, yes, but I don't like it :)

Please consider doing that anyway as there are ongoing janitor
projects that are removing the redundant if clauses...

                                           Pekka
