Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbVI3Stp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbVI3Stp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 14:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbVI3Stp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 14:49:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43174 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965062AbVI3Sto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 14:49:44 -0400
Subject: RE: I request inclusion of SAS Transport Layer and AIC-94xx
	intothe kernel
From: Arjan van de Ven <arjan@infradead.org>
To: James.Smart@Emulex.Com
Cc: mark_salyzyn@adaptec.com, Luben_Tuikov@adaptec.com,
       andrew.patterson@hp.com, dougg@torque.net, torvalds@osdl.org,
       ltuikov@yahoo.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <9BB4DECD4CFE6D43AA8EA8D768ED51C20F46D5@xbl3.ma.emulex.com>
References: <9BB4DECD4CFE6D43AA8EA8D768ED51C20F46D5@xbl3.ma.emulex.com>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 20:49:25 +0200
Message-Id: <1128106165.3012.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-30 at 14:36 -0400, James.Smart@Emulex.Com wrote:
> > On Fri, 2005-09-30 at 13:07 -0400, Salyzyn, Mark wrote:
> > > At the SAS BOF, I indicated that it would not be much trouble to
> > > translate the CSMI handler in the aacraid driver to a similar sysfs
> > > arrangement. If such info can be mined from a firmware 
> > based RAID card,
> > > every driver should be able to do so. The spec writers 
> > really need to
> > > consider rewriting SDI for sysfs (if they have not already) and move
> > > away from an ABI.
> > 
> > that makes me wonder... why and how does T10 control linux abi's ??
> 
> Agreed. The most they should be doing is defining a library interface, and
> letting the library hide the system specifics (like t11 and hbaapi, who
> still got parts wrong).  It also changes the argument from being a "linux abi"
> to being "a defacto application/library abi". 

and not an ABI but an API. Which is important to allow the OS designers
deal with architecture differences better.


