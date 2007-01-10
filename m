Return-Path: <linux-kernel-owner+w=401wt.eu-S932548AbXAJE5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbXAJE5t (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 23:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbXAJE5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 23:57:49 -0500
Received: from web55602.mail.re4.yahoo.com ([206.190.58.226]:31430 "HELO
	web55602.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932548AbXAJE5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 23:57:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=s25Y5pN1pgcW4LqppRAQgR5PsUoOxUaBRN8qdni0cpas6+XqxaxSjTGrYar16/O7vbf5IQki8uLAAjsi+kCMl6BXOVNN2TxRqYxidVGDzStBo0br3F/F9FSzaj8lHj2Fhht+K0ZYUz9kE5Wy/XRFAambN/c0s7cI7x4QVP/ixVE=;
X-YMail-OSG: 0Adug3IVM1n6IyFRGRnNrs_V9VHQ2kV3Awk7uf6RyWial1NR4FzJRGCNMtoxOueV_kOGr1jt9ZBdgCZKqJVmrZZiEudV6DDaSmTCe5ARP1JGx.PZAnoVMQuALT2nEVUX6dMwDJT.W59TzA--
Date: Tue, 9 Jan 2007 20:57:47 -0800 (PST)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Valdis.Kletnieks@vt.edu, Pekka Enberg <penberg@cs.helsinki.fi>,
       Hua Zhong <hzhong@gmail.com>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20070109111955.85496022.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <610734.13017.qm@web55602.mail.re4.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Randy Dunlap <randy.dunlap@oracle.com> wrote:

> On Tue, 9 Jan 2007 11:02:35 -0800 (PST) Amit Choudhary wrote:
> 
> No thanks.  If a driver author wants to maintain driver state
> that way, it's OK, but that doesn't make it a global requirement.
> 

Ok. So, a driver can have its own local definition of KFREE() macro.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
