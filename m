Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVo/V+CPPbwBn5RFORV0QmHCjaPA==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Fri, 02 Jan 2004 19:58:36 +0000
Message-ID: <003301c415a3$f57e8aa0$d100000a@sbs2003.local>
Date: Mon, 29 Mar 2004 16:39:01 +0100
From: "Patrick Gefre" <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Mailer: Microsoft CDO for Exchange 2000
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: <Administrator@smtp.paston.co.uk>
Cc: <akpm@osdl.org>, <davidm@napali.hpl.hp.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Updating our sn code in 2.6
References: <20031228143603.A20391@infradead.org> <Pine.SGI.3.96.1031230151441.2502941C-100000@daisy-e236.americas.sgi.com> <20031230212450.A9765@infradead.org>
Content-Class: urn:content-classes:message
In-Reply-To: <20031230212450.A9765@infradead.org>
Importance: normal
Priority: normal
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1"
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Content-Transfer-Encoding: 7bit
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:39:02.0328 (UTC) FILETIME=[F5F0FB80:01C415A3]

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

