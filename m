Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUFQRyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUFQRyp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 13:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUFQRyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 13:54:45 -0400
Received: from magic.adaptec.com ([216.52.22.17]:8351 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261239AbUFQRym convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 13:54:42 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PATCH: Further aacraid work
Date: Thu, 17 Jun 2004 13:54:38 -0400
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189FD2407B@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PATCH: Further aacraid work
Thread-Index: AcRUiru1sE+Be+YXTsKGtapG1eSPcgACMYqA
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Alan Cox" <alan@redhat.com>, "Clay Haapala" <chaapala@cisco.com>
Cc: "James Bottomley" <James.Bottomley@steeleye.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "SCSI Mailing List" <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And I might add, undoing the entropy to result in the descending page
list (but that is the forth time I've said this).

I ran heavy sequential load overnight and continued to have this
characteristic when taking snapshots of command SG lists. The average SG
element size statistically was 4168 bytes.

Sincerely -- Mark Salyzyn

-----Original Message-----
From: Alan Cox [mailto:alan@redhat.com] 
Sent: Thursday, June 17, 2004 12:47 PM
To: Clay Haapala
Cc: James Bottomley; Salyzyn, Mark; Christoph Hellwig; Alan Cox; Linux
Kernel; SCSI Mailing List
Subject: Re: PATCH: Further aacraid work

On Thu, Jun 17, 2004 at 11:32:29AM -0500, Clay Haapala wrote:
> So, on regular x86 this is a matter of convenience/timing, and the
> page assignments will tend toward, but not always be, random 1-page
> entries as the system is used.

In 2.4 at least it shows no sign of degenerating in that way, something
in the VM is undoing the entropy

