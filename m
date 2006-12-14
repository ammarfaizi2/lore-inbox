Return-Path: <linux-kernel-owner+w=401wt.eu-S1751125AbWLNT63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWLNT63 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 14:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWLNT63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 14:58:29 -0500
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:1723 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751125AbWLNT60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 14:58:26 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Theodore Tso <tytso@mit.edu>, thunder7@xs4all.nl,
       Arjan van de Ven <arjan@infradead.org>,
       Franck Pommereau <pommereau@univ-paris12.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Clarify i386/Kconfig explanation of the HIGHMEM config options
Date: Thu, 14 Dec 2006 19:58:40 +0000
User-Agent: KMail/1.9.5
References: <458118BB.5050308@univ-paris12.fr> <20061214152721.GA5652@amd64.of.nowhere> <20061214153754.GD9079@thunk.org>
In-Reply-To: <20061214153754.GD9079@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612141958.40519.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 December 2006 15:37, Theodore Tso wrote:
> > +	  1 Gigabyte or more total physical RAM, answer "off" here.
>
> I don't think your proposed wording (1 gigabyte or more) versus (more
> than 1 gigabyte) doesn't really change the sense of this.

It does, because if you have exactly 1G of RAM, you should be using 
CONFIG_HIGHMEM, otherwise you will only be able to see ~896M.

This is >1G versus >=1G, the latter is clearly more correct.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
