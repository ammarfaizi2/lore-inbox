Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWANLux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWANLux (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 06:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWANLuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 06:50:52 -0500
Received: from [62.38.115.213] ([62.38.115.213]:35999 "EHLO pfn3.pefnos")
	by vger.kernel.org with ESMTP id S1750991AbWANLuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 06:50:52 -0500
From: "P. Christeas" <p_christ@hol.gr>
To: Andrew Morton <akpm@osdl.org>, hch@lst.de, linux-kernel@vger.kernel.org,
       Ian Kent <raven@themaw.net>
Subject: Re: Regression in Autofs, 2.6.15-git
Date: Sat, 14 Jan 2006 13:50:28 +0200
User-Agent: KMail/1.9
References: <200601140217.56724.p_christ@hol.gr> <20060114033441.0d80b9f2.akpm@osdl.org>
In-Reply-To: <20060114033441.0d80b9f2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601141350.31033.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 January 2006 1:34 pm, you wrote:
> Thanks for working that out.
>
> It works for me.  Are you able to capture the oops output?
Works in what sense? Are you able to reproduce the oops?
It is quite difficult to reproduce the oops, since it makes the whole system 
freeze (the fs part is oopsed, and then all processes depend on it). Hence 
I've called it "hard" . It may be captured with a serial console, I 'll give 
it a try..
