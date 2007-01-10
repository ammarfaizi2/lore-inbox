Return-Path: <linux-kernel-owner+w=401wt.eu-S932582AbXAJHVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbXAJHVv (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 02:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbXAJHVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 02:21:51 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:55601 "EHLO
	mail.cs.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932582AbXAJHVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 02:21:50 -0500
Date: Wed, 10 Jan 2007 09:21:48 +0200 (EET)
From: Pekka J Enberg <penberg@cs.helsinki.fi>
To: "Serge E. Hallyn" <serue@us.ibm.com>
cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Mimi Zohar <zohar@us.ibm.com>,
       akpm@osdl.org, kjhall@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
       safford@watson.ibm.com
Subject: Re: mprotect abuse in slim
In-Reply-To: <20070109231449.GA4547@sergelap.austin.ibm.com>
Message-ID: <Pine.LNX.4.64.0701100914550.22496@sbz-30.cs.Helsinki.FI>
References: <OFE2C5A2DE.3ADDD896-ON8525725D.007C0671-8525725D.007D2BA9@us.ibm.com>
 <1168312045.3180.140.camel@laptopd505.fenrus.org> <20070109094625.GA11918@infradead.org>
 <20070109231449.GA4547@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2007, Serge E. Hallyn wrote:
> Whatever happened with Pekka's revoke submissions?  Did you lose
> interest after
> http://www.kernel.org/pub/linux/kernel/people/penberg/patches/revoke/2.6.19-rc1/revoke-2.6.19-rc1,
> or was it decided that the approach was unworkable?

Lack of time. Also, I would love to hear comments on the way I am doing 
revoke on shared mappings. There are few open issues remaining, mainly, 
supporting munmap(2) for revoked mappings.

			Pekka
