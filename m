Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbTJJUpM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 16:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbTJJUpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 16:45:12 -0400
Received: from mx2.redhat.com ([66.187.237.31]:53767 "EHLO mx2.redhat.com")
	by vger.kernel.org with ESMTP id S262493AbTJJUpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 16:45:10 -0400
Date: Fri, 10 Oct 2003 13:44:55 -0700
From: Richard Henderson <rth@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org
Subject: Re: using void variables as linker-script symbol refs
Message-ID: <20031010204455.GE19470@redhat.com>
Mail-Followup-To: Richard Henderson <rth@redhat.com>,
	David Howells <dhowells@redhat.com>, gcc@gcc.gnu.org,
	linux-kernel@vger.kernel.org
References: <15494.1065808168@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15494.1065808168@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 06:49:28PM +0100, David Howells wrote:
> 	extern int _stext[], _etext[];

s/int/char/ and this is the most correct way.  Really.


r~
