Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbTFDUot (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 16:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264063AbTFDUos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 16:44:48 -0400
Received: from thumper2.emsphone.com ([199.67.51.102]:35470 "EHLO
	thumper2.emsphone.com") by vger.kernel.org with ESMTP
	id S264054AbTFDUn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 16:43:57 -0400
Date: Wed, 4 Jun 2003 15:57:16 -0500
From: Andrew Ryan <genanr@emsphone.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS io errors on transfer from system running 2.4 to system running 2.5
Message-ID: <20030604205716.GA11537@thumper2.emsphone.com>
References: <200306031912.53569.mflt1@micrologica.com.hk> <20030603144257.GA31734@thumper2.emsphone.com> <shs7k83p2g6.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shs7k83p2g6.fsf@charged.uio.no>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 06:10:01PM +0200, Trond Myklebust wrote:
> 
> Tough. 'soft' is not a priority of mine. It is a broken feature...
>
No, it is a broken feature in *LINUX* post 2.4.20pre3, it's not broken in
FreeBSD or Tru64.  Regardless of what Trond says about soft mounts they
should work in Linux just as well as they do in other OSes, such as FreeBSD.

I've tried to debug and I have seen no timeouts.  I believe something is up
with the congestion routines that were added.

Yes, hard mounts work.  But so soft ones.  Linux should not have a
broken NFS.

Andy

  
