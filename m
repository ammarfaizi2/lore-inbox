Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbUEFQf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbUEFQf7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 12:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbUEFQf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 12:35:56 -0400
Received: from d61.wireless.hilander.com ([216.241.32.61]:6875 "EHLO
	ramirez.hilander.com") by vger.kernel.org with ESMTP
	id S261262AbUEFQdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 12:33:49 -0400
Date: Thu, 06 May 2004 10:33:46 -0600
From: "Alec H. Peterson" <ahp@hilander.com>
To: linux-kernel@vger.kernel.org
Subject: Re: pci_request_regions() failure
Message-ID: <85E9D28402CA2A4C4E8093BE@[192.168.0.100]>
In-Reply-To: <01D138A0E5F192A9DBDB9432@[192.168.0.100]>
References: <01D138A0E5F192A9DBDB9432@[192.168.0.100]>
X-Mailer: Mulberry/3.1.3 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Spam-Score: -4.8 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1BLlog-0005ki-Kn*YEBfP8.Tpm.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings again,

It seems that this is actually an alignment problem.  The region of memory 
that should be used (in this case ec107000-ec108fff) is not 8k aligned. 
Does anybody have any suggestions about how I can force aligned memory 
blocks?

Thanks!

Alec



