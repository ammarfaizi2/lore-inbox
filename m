Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWCVLun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWCVLun (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 06:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWCVLun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 06:50:43 -0500
Received: from z2.cat.iki.fi ([212.16.98.133]:9094 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S1750728AbWCVLun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 06:50:43 -0500
Date: Wed, 22 Mar 2006 13:50:41 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Sam Vilain <sam@vilain.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vger ate my patch!
Message-ID: <20060322115041.GB21614@mea-ext.zmailer.org>
References: <20060322061333.27638.63963.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060322061333.27638.63963.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 04:13:33PM +1200, Sam Vilain wrote:
> From:	Sam Vilain <sam@vilain.net>
> Subject: vger ate my patch!
> Date:	Tue, 22 Mar 2006 16:13:33 +1200
> To:	linux-kernel@vger.kernel.org
> Message-Id: <20060322061333.27638.63963.stgit@localhost.localdomain>
> 
> And if my theory is correct, this message will also not make it to LKML.

Hmm..  Yes it did...   I found them in junk-pile, and the reason was:

 From:   Sam Vilain <sam@vilain.net>
 Subject: [RFC] [PATCH 3/7] [vserver] Add /proc visibility of vserver info
 Date:   Tue, 21 Mar 2006 18:13:35 +1200
 To:     linux-kernel@vger.kernel.org
 Cc:     Herbert Poetzl <herbert@13thfloor.at>,
         Eric W.Biederman <ebiederm@xmission.com>,
         OpenVZ developers list <dev@openvz.org>,
         Dave Hansen <haveblue@us.ibm.com>, Serge E.Hallyn <serue@us.ibm.com>,
         Andrew Morton <akpm@osdl.org>
 Illegal-Object: Syntax error in Cc: addresses found on vger.kernel.org:
         Cc:     Eric W.Biederman <ebiederm@xmission.com>
                         ^     ^-missing end of address
                  \-extraneous tokens in address



Your MUA software doesn't do proper text element quoting, when said
element has RFC-822 specials in it.

Had the Cc: been either of following, there would not have been this
syntax error biting on junk filter:

      Eric W Biederman  <ebiederm@xmission.com>
      "Eric W. Biederman" <ebiederm@xmission.com>

Have fun.

  /Matti Aarnio
