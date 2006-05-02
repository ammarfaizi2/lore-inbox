Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWEBOtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWEBOtD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 10:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWEBOtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 10:49:03 -0400
Received: from pat.uio.no ([129.240.10.6]:63719 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964849AbWEBOtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 10:49:01 -0400
Subject: Re: Er, whoops!
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Robert F. Merrill" <rfm@CSUA.Berkeley.EDU>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200605020743.k427hWi1023139@soda.csua.berkeley.edu>
References: <200605020743.k427hWi1023139@soda.csua.berkeley.edu>
Content-Type: text/plain
Date: Tue, 02 May 2006 07:48:46 -0700
Message-Id: <1146581326.9288.13.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.112, required 12,
	autolearn=disabled, AWL 0.38, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-02 at 00:43 -0700, Robert F. Merrill wrote:
> I apologize for the recent emailing of a call trace with no subject or text in it!
> 
> It's some weird nfs thing (a different one than I last sent)
> -

Do the following two patches (against 2.6.17-rc3) fix it?

http://client.linux-nfs.org/Linux-2.6.x/2.6.17-rc3/linux-2.6.17-003-nlm_sem_to_mutex.dif

http://client.linux-nfs.org/Linux-2.6.x/2.6.17-rc3/linux-2.6.17-004-fix_nlm_reclaim_races.dif

Cheers,
  Trond

