Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWEVXKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWEVXKq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 19:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWEVXKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 19:10:46 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:47505 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751290AbWEVXKp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 19:10:45 -0400
Message-ID: <447244EB.1010101@vilain.net>
Date: Tue, 23 May 2006 11:10:35 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, ebiederm@xmission.com, xemul@sw.ru,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Cedric Le Goater <clg@fr.ibm.com>, serue@us.ibm.com
Subject: Re: [PATCH] namespaces: uts_ns: make information visible via	/proc/PID/uts
 directory
References: <20060522052425.27715.94562.stgit@localhost.localdomain> <1148298318.17376.19.camel@localhost.localdomain> <44724414.5020505@vilain.net>
In-Reply-To: <44724414.5020505@vilain.net>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain wrote:

>I didn't grab uts_sem.  That semaphore could be made per-uts_ns, in
>theory.  Whether anyone cares about contention that much is another
>question.
>  
>

FWIW, the uts_sem isn't mentioned anywhere in the
/proc/sys/kernel/osname sysctl, either.  So that interface probably
isn't safe on SMP/preempt.

Sam.
