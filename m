Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbTK1BNB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 20:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbTK1BNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 20:13:01 -0500
Received: from pat.uio.no ([129.240.130.16]:679 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261779AbTK1BNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 20:13:00 -0500
To: "J.A. Magallon" <jamagallon@able.es>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Locking over NFS
References: <20031127230937.GA23147@werewolf.able.es>
	<shsu14pz4p4.fsf@charged.uio.no>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 27 Nov 2003 20:12:55 -0500
In-Reply-To: <shsu14pz4p4.fsf@charged.uio.no>
Message-ID: <shszneh8fe0.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Trond Myklebust <trond.myklebust@fys.uio.no> writes:

     > Yes, it works just fine.

     > You're probably failing to run rpc.statd or something like
     > that. See the NFS FAQ & HOWTO on http://nfs.sourceforge.net

Come to think of it, are you perhaps trying to set the lock on an
NFSroot volume? Those are automatically mounted with the 'nolock'
mount option set.

Cheers,
  Trond
