Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbTEHPpK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 11:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbTEHPpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 11:45:10 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:7047
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261786AbTEHPpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 11:45:09 -0400
Subject: Re: The disappearing sys_call_table export.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Terje Malmedal <terje.malmedal@usit.uio.no>
Cc: Terje Eggestad <terje.eggestad@scali.com>,
       Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       D.A.Fedorov@inp.nsk.su
In-Reply-To: <E19DkT9-0000Wh-00@aqualene.uio.no>
References: <1052122784.2821.4.camel@pc-16.office.scali.no>
	 <20030505092324.A13336@infradead.org>
	 <1052127216.2821.51.camel@pc-16.office.scali.no>
	 <1052133402.29361.2.camel@dhcp22.swansea.linux.org.uk>
	 <E19DkT9-0000Wh-00@aqualene.uio.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052405926.10037.55.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 May 2003 15:58:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-08 at 13:25, Terje Malmedal wrote:
> How about a
> 
> EXPORT_SYMBOL_GPL_AND_DONT_EVEN_THINK_ABOUT_SENDING_A_BUG_REPORT(sys_call_table);

Its in read only space nowdays anyway

> A server for an online internet game had several months of uptime and
> I needed to rotate the log-files so I made a module which trapped
> sys_write and closed and reopened the file with a new name before
> continuing[1]. 

man ptrace

