Return-Path: <linux-kernel-owner+w=401wt.eu-S1751738AbWLMXbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbWLMXbF (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 18:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbWLMXbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 18:31:04 -0500
Received: from elch.in-berlin.de ([192.109.42.5]:55355 "EHLO elch.in-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738AbWLMXbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 18:31:03 -0500
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 18:31:03 EST
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <458089A4.9060102@s5r6.in-berlin.de>
Date: Thu, 14 Dec 2006 00:15:48 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Robert Crocombe <rcrocomb@gmail.com>
CC: Keith Curtis <Keith.Curtis@digeo.com>,
       linux1394-devel <linux1394-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: isochronous receives?
References: <AccTUZEOi7v6J84+R+eLGKj8lA2txQAz+0pA>	<DD2010E58E069B40886650EE617FCC0CBA8EC9@digeo-mail1.digeo.com> <e6babb600612130630y341aaadehb0436ade65ea6f7d@mail.gmail.com> <45804615.3060004@s5r6.in-berlin.de>
In-Reply-To: <45804615.3060004@s5r6.in-berlin.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> /* can be used for tag = 0...3 and ORed together for multiple tags */
> #define RAW1394_IR_MATCH_TAG(tag)   (1<<((tag)&3))

PS: or  ((tag)>>2 ? 0 : 1<<(tag))  or just  (1<<(tag))

> #define RAW1394_IR_MATCH_ALL_TAGS   -1

-- 
Stefan Richter
-=====-=-==- ==-- -===-
http://arcgraph.de/sr/
