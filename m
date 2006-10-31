Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423822AbWJaThA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423822AbWJaThA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 14:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423823AbWJaThA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 14:37:00 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:27584 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1423822AbWJaTg7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 14:36:59 -0500
Message-ID: <4547A5D2.2080900@gmail.com>
Date: Tue, 31 Oct 2006 20:36:50 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>,
       Guillermo Marcus <marcus@ti.uni-mannheim.de>,
       linux-kernel@vger.kernel.org
Subject: Re: mmaping a kernel buffer to user space
References: <4547150F.8070408@ti.uni-mannheim.de> <4547733B.9040801@gmail.com> <20061031192252.GA26625@flint.arm.linux.org.uk>
In-Reply-To: <20061031192252.GA26625@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Tue, Oct 31, 2006 at 05:00:59PM +0100, Jiri Slaby wrote:
>> Piece of code please. pci_alloc_consistent calls __get_free_pages, and there
>> should be no problem with mmaping this area.
> 
> That is an implementation detail which is not portable to other
> architectures.  Please don't encourage people to use non-portable
> implementation details.

Sorry, I stand corrected, thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
