Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752498AbWJ0Vct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbWJ0Vct (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 17:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752501AbWJ0Vct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 17:32:49 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:59678 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1752498AbWJ0Vcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 17:32:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=HcoZmrrR7CHI+LSlS4L7Dn5j3pj7RXUanrKeEl7+ciJVp9weo4BuLynfJpnJNkalXP+b1jRYwOkGDchHagy/DXJZlFzkuI2uRlBC6Ed1jNksu/X3j/ieHvmStxJ9Rs3avA8grYTmd+YCYfXfHn/X454Frc9sEzzNL0efFZWLOu8=
Message-ID: <45427AFB.8070806@gmail.com>
Date: Fri, 27 Oct 2006 17:32:43 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Randy Dunlap <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org,
       proski@gnu.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, cate@debian.org,
       gianluca@abinetworks.biz, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH ??] Re: incorrect taint of ndiswrapper
References: <1161807069.3441.33.camel@dv>	 <1161808227.7615.0.camel@localhost.localdomain>	 <20061025205923.828c620d.akpm@osdl.org>	 <20061026102630.ad191d21.randy.dunlap@oracle.com> <1161959020.12281.1.camel@laptopd505.fenrus.org>
In-Reply-To: <1161959020.12281.1.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> (it's a separate question if ndiswrapper should be in this table;
> driverloader should be, it's non-GPL at all, so that part of your patch
> is broken)
>   

If driverloader is not GPLed then why does it need to be treated
exceptionally to begin with? It taints the kernel anyway because of its
license.

---
fm

