Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVo/uAr+ExIA5RTnqN2Hp6SMpOxQ==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Fri, 02 Jan 2004 20:15:51 +0000
Message-ID: <003d01c415a3$fb805280$d100000a@sbs2003.local>
Date: Mon, 29 Mar 2004 16:39:11 +0100
Content-Transfer-Encoding: 7bit
From: "Christoph Hellwig" <hch@infradead.org>
To: <Administrator@smtp.paston.co.uk>
Cc: "Christoph Hellwig" <hch@infradead.org>, <akpm@osdl.org>,
        <davidm@napali.hpl.hp.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Updating our sn code in 2.6
X-Mailer: Microsoft CDO for Exchange 2000
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patrick Gefre <pfg@sgi.com>, akpm@osdl.org, davidm@napali.hpl.hp.com,
	linux-kernel@vger.kernel.org
References: <20031228143603.A20391@infradead.org> <Pine.SGI.3.96.1031230151441.2502941C-100000@daisy-e236.americas.sgi.com> <20031230212450.A9765@infradead.org> <3FF5CADE.9010703@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
Content-Class: urn:content-classes:message
Importance: normal
User-Agent: Mutt/1.2.5.1i
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
In-Reply-To: <3FF5CADE.9010703@sgi.com>; from pfg@sgi.com on Fri, Jan 02, 2004 at 01:47:42PM -0600
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:39:12.0437 (UTC) FILETIME=[FBF77E50:01C415A3]

On Fri, Jan 02, 2004 at 01:47:42PM -0600, Patrick Gefre wrote:
> OK - I updated the patches as Christoph suggested (removed 
> hwgraph_path_lookup() from 000, removed
> snia64_pci_find_bios() from 014, removed pcibr_businfo_get() from 030 
> and dropped 071).
> 
> I took the reorg patch (075) out for now - I am reworking it along with 
> our next set of patches.
> 
> So I think they are ready to go ?

Yes.  030 still has some really strange additions but we can back that
out later.

For the next round of patched I would be nice if you could get the
attribution of the patches right, though..

