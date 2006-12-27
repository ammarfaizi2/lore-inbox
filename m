Return-Path: <linux-kernel-owner+w=401wt.eu-S932923AbWL0Fw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932923AbWL0Fw5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 00:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932915AbWL0Fw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 00:52:57 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:34945
	"EHLO grelber.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932916AbWL0Fw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 00:52:56 -0500
From: Rob Landley <rob@landley.net>
To: ray-gmail@madrabbit.org
Subject: Re: Feature request: exec self for NOMMU.
Date: Wed, 27 Dec 2006 00:51:52 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org,
       "David McCullough" <david_mccullough@au.securecomputing.com>
References: <200612261823.07927.rob@landley.net> <2c0942db0612262113v5b504aecmdd922193415b60de@mail.gmail.com>
In-Reply-To: <2c0942db0612262113v5b504aecmdd922193415b60de@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612270051.52690.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 December 2006 12:13 am, Ray Lee wrote:
> How about openning an fd to yourself at the beginning of execution, then
> calling fexecve later?

I haven't got a man page for fexecve.  Does libc have it?

In the 2.6.19 kernel: "find . | xargs grep fexecve" produces no hits.

Are you sure there _is_ one?

Rob
-- 
"Perfection is reached, not when there is no longer anything to add, but
when there is no longer anything to take away." - Antoine de Saint-Exupery
