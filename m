Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbTIGWOe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 18:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbTIGWOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 18:14:34 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:36586 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261621AbTIGWOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 18:14:32 -0400
Date: Sun, 7 Sep 2003 23:13:23 +0100
From: Dave Jones <davej@redhat.com>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oops_in_progress is unlikely()
Message-ID: <20030907221323.GC28927@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Mitchell Blank Jr <mitch@sfgoth.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20030907064204.GA31968@sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030907064204.GA31968@sfgoth.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 01:42:04AM -0500, Mitchell Blank Jr wrote:
 > Andrew - thanks for applying my last patch; thought you might be interested
 > in this trivial one too.  Patch is versus 2.6.0-test4-bk8, I expect it
 > will also apply against current -mm.

none of this patch seems to touch particularly performance critical code.
Is it really worth adding these macros to every if statement in the kernel?
There comes a point where readability is lost, for no measurable gain.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
