Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbUBXQfv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 11:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbUBXQfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 11:35:51 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:39816 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262267AbUBXQfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 11:35:50 -0500
Date: Tue, 24 Feb 2004 17:35:30 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: sandr8@crocetta.org
Cc: Gautam Pagedar <gautam@cins.unipune.ernet.in>,
       linux-kernel@vger.kernel.org
Subject: Re: can i modify ls
Message-ID: <20040224163530.GA24370@louise.pinerecords.com>
References: <005601c3fd75$1c681510$8c01080a@crayii> <403B7402.2000008@universitari.crocetta.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403B7402.2000008@universitari.crocetta.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb-24 2004, Tue, 15:55 +0000
Alessandro Salvatori <a.salvatori@universitari.crocetta.org> wrote:

> it's quite interesting...

Actually, it's not.

1) The presence/absence of the read permission on a directory determines
	whether the user will be able to list the directory's contents.

2) The fs permission model is enforced by the kernel.  Trying to impose
	additional restrictions in userspace is fragile, futile and
	an incredibly stupid idea.

-- 
Tomas Szepe <szepe@pinerecords.com>
