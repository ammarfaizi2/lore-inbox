Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318980AbSICXXw>; Tue, 3 Sep 2002 19:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318983AbSICXXn>; Tue, 3 Sep 2002 19:23:43 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:19185
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318980AbSICXXc>; Tue, 3 Sep 2002 19:23:32 -0400
Subject: Re: aic7xxx sets CDR offline, how to reset?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Doug Ledford <dledford@redhat.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <20020903184216.F12201@redhat.com>
References: <dledford@redhat.com>
	<200209032148.g83LmeP09177@localhost.localdomain> 
	<20020903184216.F12201@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 04 Sep 2002 00:29:49 +0100
Message-Id: <1031095789.21409.49.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-03 at 23:42, Doug Ledford wrote:
> Not really.  It hasn't been done yet, but one of my goals is to change the 
> scsi commands over to reasonable list usage (finally) so that we can avoid 
> all these horrible linear scans it does now looking for an available 
> command (it also means things like SCSI_OWNER_MID_LAYER can go away 

At least partly done in 2.4-ac and waiting pushing to Marcelo. I believe
Hugh contributed the O(1) command finder


