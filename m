Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265634AbUABT4J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 14:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265635AbUABT4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 14:56:08 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:55916 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265634AbUABT4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 14:56:05 -0500
Message-ID: <3FF5CADE.9010703@sgi.com>
Date: Fri, 02 Jan 2004 13:47:42 -0600
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: akpm@osdl.org, davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updating our sn code in 2.6
References: <20031228143603.A20391@infradead.org> <Pine.SGI.3.96.1031230151441.2502941C-100000@daisy-e236.americas.sgi.com> <20031230212450.A9765@infradead.org>
In-Reply-To: <20031230212450.A9765@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Tue, Dec 30, 2003 at 03:21:13PM -0600, Pat Gefre wrote:
>  
>
>>I'll drop 071. So I can assume that if I get rid of the renaming in 075
>>you are OK with that ?
>>    
>>
>
>Yes.  I don't like some of the stuff it doesn, but it's defintily not
>a showstopper.
>  
>
OK - I updated the patches as Christoph suggested (removed 
hwgraph_path_lookup() from 000, removed
snia64_pci_find_bios() from 014, removed pcibr_businfo_get() from 030 
and dropped 071).

I took the reorg patch (075) out for now - I am reworking it along with 
our next set of patches.

So I think they are ready to go ?

The patchset is at:  ftp://oss.sgi.com/projects/sn2/sn2-update/

-- Pat

