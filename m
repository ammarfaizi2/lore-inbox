Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266545AbUGKKYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266545AbUGKKYL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 06:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266550AbUGKKYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 06:24:10 -0400
Received: from ny03.mtek.chalmers.se ([129.16.60.203]:4110 "HELO
	ny03.mtek.chalmers.se") by vger.kernel.org with SMTP
	id S266545AbUGKKX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 06:23:57 -0400
Message-ID: <40F11539.1050309@am.chalmers.se>
Date: Sun, 11 Jul 2004 12:23:53 +0200
From: Thomas Svedberg <thsv@am.chalmers.se>
User-Agent: Mozilla Thunderbird 0.6+ (X11/20040604)
X-Accept-Language: en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: Zoltan Boszormenyi <zboszor@dunaweb.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm7
References: <A6974D8E5F98D511BB910002A50A6647615FFB70@hdsmsx403.hd.intel.com> <1089512622.32038.17.camel@dhcppc2>
In-Reply-To: <1089512622.32038.17.camel@dhcppc2>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
> On Sat, 2004-07-10 at 02:21, Zoltan Boszormenyi wrote:
> 
>>Hi,
>>
>>I found in my logs something that indicates problems with ACPI:
>>
>>ACPI: Subsystem revision 20040615
>>ACPI: System description tables not found
>>     ACPI-0084: *** Error: acpi_load_tables: Could not get RSDP, 
>>AE_NOT_FOUND
>>     ACPI-0134: *** Error: acpi_load_tables: Could not load tables: 
>>AE_NOT_FOUND
>>ACPI: Unable to load the System Description Tables
> 
> ...
> 
>>Machine is MSI K8T Neo FIS2R with fairly recent 1.6 BIOS.
>>I dont have this with Linux-2.6.7.
> 
> 
> Interesting, we'd seen this BIOS bug only on Dell so far.
> 
> Please test the patch here:
> http://bugzilla.kernel.org/show_bug.cgi?id=2990

I have the same MB but BIOS 1.7, same problem but the patch mentioned 
above fixed it.

-- 
/ Thomas
.......................................................................
  Thomas Svedberg
  Department of Applied Mechanics
  Chalmers University of Technology

  Address: S-412 96 Göteborg, SWEDEN
  E-mail : thsv@bigfoot.com, thsv@am.chalmers.se
  Phone  : +46 31 772 1522
  Fax    : +46 31 772 3827
.......................................................................
