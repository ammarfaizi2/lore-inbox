Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265444AbUBFNlj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 08:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265464AbUBFNlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 08:41:39 -0500
Received: from pop.gmx.net ([213.165.64.20]:32646 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265444AbUBFNlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 08:41:37 -0500
X-Authenticated: #4512188
Message-ID: <4023998E.9040404@gmx.de>
Date: Fri, 06 Feb 2004 14:41:34 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: a.verweij@student.tudelft.nl
CC: Craig Bradney <cbradney@zip.com.au>, Daniel Drake <dan@reactivated.net>,
       =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech@wanadoo.es>,
       david+challenge-response@blue-labs.org, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
References: <Pine.GHP.4.44.0402061433510.7943-100000@elektron.its.tudelft.nl>
In-Reply-To: <Pine.GHP.4.44.0402061433510.7943-100000@elektron.its.tudelft.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjen Verweij wrote:
 > It would probably be more useful if I included the URL as well duh... 
(thx
 > Craig)
 >
 > http://atlas.et.tudelft.nl/verwei90/nforce2/
 > http://atlas.et.tudelft.nl/verwei90/nforce2/index.html

     * 3.2 Turning off the CPU bus disconnect in the BIOS? (verify) 
(drawback: causes cpu to run significantly hotter)

Inprecice: CPU runs as hot as without disconnect, only without load, cpu 
disconnect lets the cpu cool down.

With athcool you can alsao turn it off, or there is a quirk-patch 
available from Bart.

     * 3.3 Apply patches cooked up by Ross Dickson, possibly in 
conjunction with 3.2? (verify)
           o 3.3.1 Seems to work for Craig Bradney (hardware unknown, 
some Asus board?) and Prakash K. Cheemplavam (Abit NF7-S)

I have Rev2 (2.0) board and d22 (or 2.2 ? Abit has a strange way of 
numbering.) Bios. I only applied first patch. I already use an 
equivalent to the second one.

Prakash
