Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265084AbUFVXTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265084AbUFVXTF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 19:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbUFVXSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 19:18:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:422 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266217AbUFVXKO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 19:10:14 -0400
Message-ID: <40D8BC40.9030104@pobox.com>
Date: Tue, 22 Jun 2004 19:09:52 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. J. Lu" <hjl@lucon.org>
CC: linux kernel <linux-kernel@vger.kernel.org>,
       linux ia64 kernel <linux-ia64@vger.kernel.org>
Subject: Re: Does parallel make work for modules?
References: <20040622220813.GA306@lucon.org>
In-Reply-To: <20040622220813.GA306@lucon.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. J. Lu wrote:
> When building 2.6.7 on a 4way Linux/ia64, "make -j4 modules" doesn't
> spawn 4 jobs. I got


BTW, you don't need to bother with a separate 'make modules' step anymore.

'make -jN' should build everything, including the default boot image for 
your architecture.

	Jeff


