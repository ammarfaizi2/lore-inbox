Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266619AbUGKPu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266619AbUGKPu1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 11:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266620AbUGKPu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 11:50:27 -0400
Received: from wl-193.226.227-253-szolnok.dunaweb.hu ([193.226.227.253]:18846
	"EHLO szolnok.dunaweb.hu") by vger.kernel.org with ESMTP
	id S266619AbUGKPuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 11:50:25 -0400
Message-ID: <40F1619D.4080001@dunaweb.hu>
Date: Sun, 11 Jul 2004 17:49:49 +0200
From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.4.1) Gecko/20031114
X-Accept-Language: hu, en-US
MIME-Version: 1.0
To: Thomas Svedberg <thsv@am.chalmers.se>
CC: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm7
References: <A6974D8E5F98D511BB910002A50A6647615FFB70@hdsmsx403.hd.intel.com> <1089512622.32038.17.camel@dhcppc2> <40F11539.1050309@am.chalmers.se>
In-Reply-To: <40F11539.1050309@am.chalmers.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Svedberg írta:
> Len Brown wrote:
> 
>> On Sat, 2004-07-10 at 02:21, Zoltan Boszormenyi wrote:
>>
>>> Hi,
>>>
>>> I found in my logs something that indicates problems with ACPI:
>>>
>>> ACPI: Subsystem revision 20040615
>>> ACPI: System description tables not found
>>>     ACPI-0084: *** Error: acpi_load_tables: Could not get RSDP, 
>>> AE_NOT_FOUND
>>>     ACPI-0134: *** Error: acpi_load_tables: Could not load tables: 
>>> AE_NOT_FOUND
>>> ACPI: Unable to load the System Description Tables
>>
>>
>> ...
>>
>>> Machine is MSI K8T Neo FIS2R with fairly recent 1.6 BIOS.
>>> I dont have this with Linux-2.6.7.
>>
>>
>>
>> Interesting, we'd seen this BIOS bug only on Dell so far.
>>
>> Please test the patch here:
>> http://bugzilla.kernel.org/show_bug.cgi?id=2990
> 
> 
> I have the same MB but BIOS 1.7, same problem but the patch mentioned 
> above fixed it.
> 

Yes, it worked for me, too.

Bst regards,
Zoltán Böszörményi


