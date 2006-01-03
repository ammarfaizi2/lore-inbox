Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWACXGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWACXGZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWACXGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:06:25 -0500
Received: from ns1.suse.de ([195.135.220.2]:63908 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964839AbWACXGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:06:24 -0500
From: Andi Kleen <ak@suse.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [PATCH] [RFC] Optimize select/poll by putting small data sets on the stack
Date: Wed, 4 Jan 2006 00:07:08 +0100
User-Agent: KMail/1.8
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200601032158.14057.ak@suse.de> <9a8748490601031422x2cd586f3vd8849723b659820e@mail.gmail.com>
In-Reply-To: <9a8748490601031422x2cd586f3vd8849723b659820e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601040007.08747.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 January 2006 23:22, Jesper Juhl wrote:

> Got an easy way to benchmark this?
> I'd like to test it on my box and provide some feedback, but I'd need
> a way to benchmark, and if you have an easy way to do that already
> figured out it would save me having to write my own :)

I have a simple micro benchmark, but I don't think it makes
sense to repeat these measurements (they are not very interesting) I'm mostly 
interested in functional testing- e.g. does it break anything for you? 

-Andi
