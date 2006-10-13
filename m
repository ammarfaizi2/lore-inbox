Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWJML47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWJML47 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 07:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWJML47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 07:56:59 -0400
Received: from heisenberg.zen.co.uk ([212.23.3.141]:15847 "EHLO
	heisenberg.zen.co.uk") by vger.kernel.org with ESMTP
	id S1751425AbWJML46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 07:56:58 -0400
From: David Johnson <dj@david-web.co.uk>
To: Jarek Poplawski <jarkao2@o2.pl>
Subject: Re: Hardware bug or kernel bug?
Date: Fri, 13 Oct 2006 12:56:53 +0100
User-Agent: KMail/1.9.5
References: <20061013085605.GA1690@ff.dom.local> <200610131020.48232.dj@david-web.co.uk> <20061013105807.GB1690@ff.dom.local>
In-Reply-To: <20061013105807.GB1690@ff.dom.local>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610131256.54546.dj@david-web.co.uk>
X-Originating-Heisenberg-IP: [82.69.29.67]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 October 2006 11:58, Jarek Poplawski wrote:
>
> PS: I hope you tested it also under internal stress (heavy
> copying plus computing).

Yes, I did. No individual factor triggers the bug (high CPU load, lots of disk 
activity, high network load, etc.) nor does any other combination of factors 
other than what I mentioned before (high network load, some disk activity, 
some CPU load).

Both scp and rsync trigger it reliably, but FTP does not trigger it at all. So 
CPU load (which scp and rsync generates but FTP does not) must be a key part 
of the equation...

Regards,
David.
