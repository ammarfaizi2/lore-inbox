Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWHaIFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWHaIFm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 04:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWHaIFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 04:05:42 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:55786 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751234AbWHaIFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 04:05:40 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44F6974C.5090708@s5r6.in-berlin.de>
Date: Thu, 31 Aug 2006 10:01:16 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer
 [try #2]
References: <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com> <10117.1156522985@warthog.cambridge.redhat.com> <15945.1156854198@warthog.cambridge.redhat.com> <20060829122501.GA7814@infradead.org> <44F44639.90103@s5r6.in-berlin.de> <44F44B8D.4010700@s5r6.in-berlin.de> <Pine.LNX.4.64.0608300311430.6761@scrub.home> <44F5DA00.8050909@s5r6.in-berlin.de> <20060830214356.GO18276@stusta.de> <Pine.LNX.4.64.0608310039440.6761@scrub.home> <20060830233835.GT18276@stusta.de> <Pine.LNX.4.64.0608310154580.6761@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0608310154580.6761@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> On Thu, 31 Aug 2006, Adrian Bunk wrote:
[...]
>> sending users from one menu to another for first manually 
>> selecting this or that option is less easy for the user than the usage 
>> of select.
> 
> How often does he have to do that? Is it really worth it fucking with the 
> kconfig system? 

Adrian, Roman,
both the comment hack and the 'select' hack introduce redundancy into 
the Kconfig files and add maintenance cost. In addition, 'select' 
currently brings a danger of inconsistent configuration. As I said 
before, the proper solution would be enhancements to the "make 
XYZconfig" UIs to comfortably present unfulfilled dependencies, based on 
'depends on' alone. Alas my posting here is yet another one without a 
patch included...
-- 
Stefan Richter
-=====-=-==- =--- =====
http://arcgraph.de/sr/
