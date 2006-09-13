Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbWIMSHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWIMSHs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 14:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWIMSHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 14:07:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:41604 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750985AbWIMSHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 14:07:46 -0400
Date: Wed, 13 Sep 2006 11:07:35 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: David Howells <dhowells@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>, ak@suse.de,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent?
In-Reply-To: <45084833.4040602@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0609131106260.18264@schroedinger.engr.sgi.com>
References: <44F395DE.10804@yahoo.com.au>  <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com>
 <1156750249.3034.155.camel@laptopd505.fenrus.org> <11861.1156845927@warthog.cambridge.redhat.com>
 <45084833.4040602@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2006, Nick Piggin wrote:

> Comments?

You only support 64k waiters. We have had cases of software failing 
because more than 64k readers were waiting.

Please sent patches inline in order for us to be able to comment.

