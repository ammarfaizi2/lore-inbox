Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVBUOph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVBUOph (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 09:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbVBUOph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 09:45:37 -0500
Received: from aun.it.uu.se ([130.238.12.36]:38072 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261988AbVBUOpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 09:45:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16921.62437.740517.858809@alkaid.it.uu.se>
Date: Mon, 21 Feb 2005 15:44:53 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: updated list of unused kernel exports posted
In-Reply-To: <20050220001036.GB27331@ca-server1.us.oracle.com>
References: <1108847674.6304.158.camel@laptopd505.fenrus.org>
	<20050220001036.GB27331@ca-server1.us.oracle.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker writes:
 > On Sat, Feb 19, 2005 at 10:14:33PM +0100, Arjan van de Ven wrote:
 > > +get_sb_pseudo
 > 
 > 	Used by Oracle's GPL ASMLib driver, and I think by some OCFS2
 > stuff as well.

Also used by GPL perfctr-2.6 package. Al Viro just recently finally
added the EXPORT_SYMBOL, previously external modules had to duplicate
the code.

/Mikael
