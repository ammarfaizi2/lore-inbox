Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262252AbVDLOxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbVDLOxY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 10:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbVDLOpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 10:45:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:65205 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262252AbVDLOoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 10:44:12 -0400
Date: Tue, 12 Apr 2005 15:44:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: Ihalainen Nickolay <ihanic@dev.ehouse.ru>, admin@list.net.ru,
       linux-kernel@vger.kernel.org
Subject: Re: Digi Neo 8: linux-2.6.12_r2  jsm driver
Message-ID: <20050412144408.GA9796@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Kilau, Scott" <Scott_Kilau@digi.com>,
	Ihalainen Nickolay <ihanic@dev.ehouse.ru>, admin@list.net.ru,
	linux-kernel@vger.kernel.org
References: <335DD0B75189FB428E5C32680089FB9F038FB8@mtk-sms-mail01.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <335DD0B75189FB428E5C32680089FB9F038FB8@mtk-sms-mail01.digi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 09:02:42AM -0500, Kilau, Scott wrote:
> LKML, please, do *NOT* apply this patch to the kernel!
> It will cause conflicts if our customers have both the Digi DGNC and
> IBM/Digi JSM drivers installed!

Who cares?  If you're driver was written properly (which I hope for you)
it'll just skip a device that's bound to the jsm driver already.

And having additional hardware support is always a good thing, especially
if it's as trivial as that patch.
