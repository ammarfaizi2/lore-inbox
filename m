Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264637AbUEYLcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264637AbUEYLcf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 07:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUEYLcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 07:32:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50333 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264637AbUEYLcd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 07:32:33 -0400
Date: Tue, 25 May 2004 12:32:31 +0100
From: Matthew Wilcox <willy@debian.org>
To: Greg KH <greg@kroah.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [BK PATCH] PCI Express patches for 2.4.27-pre3
Message-ID: <20040525113231.GB29154@parcelfarce.linux.theplanet.co.uk>
References: <20040524210146.GA5532@kroah.com> <1085468008.2783.1.camel@laptop.fenrus.com> <20040525080006.GA1047@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040525080006.GA1047@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 01:00:06AM -0700, Greg KH wrote:
> > how does this mesh with the "2.4 is now feature frozen"?
> 
> As the major chunk of ACPI support just got added to the tree, and the
> only reason that went in was for this patch, I assumed that it was
> acceptable.  Marcelo, feel free to tell me otherwise if you do not want
> this in the 2.4 tree.

I assume it was added because Len tries to keep ACPI in 2.4 and 2.6 as
close to identical as possible.  It certainly doesn't hurt anyone to add
the ACPI functionality without the MMConfig support.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
