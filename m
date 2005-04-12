Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262481AbVDLQmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbVDLQmi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 12:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbVDLQl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 12:41:28 -0400
Received: from ns1.s2io.com ([142.46.200.198]:7402 "EHLO ns1.s2io.com")
	by vger.kernel.org with ESMTP id S262266AbVDLQfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 12:35:11 -0400
Subject: Re: [ANNOUNCE 2/6] Linux-iSCSI High-Performance Initiator
From: Dmitry Yusupov <dima@neterion.com>
To: Greg KH <greg@kroah.com>
Cc: Alex Aizman <itn780@yahoo.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050412053532.GE32372@kroah.com>
References: <425B3F58.2040000@yahoo.com>  <20050412053532.GE32372@kroah.com>
Content-Type: text/plain
Organization: Neterion, Inc
Date: Tue, 12 Apr 2005 09:34:33 -0700
Message-Id: <1113323674.10545.5.camel@beastie>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -102.5
X-Spam-Outlook-Score: ()
X-Spam-Features: EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-11 at 22:35 -0700, Greg KH wrote:
> On Mon, Apr 11, 2005 at 08:24:08PM -0700, Alex Aizman wrote:
> > +typedef uint64_t iscsi_snx_t;		/* iSCSI Data-Path session handle */
> > +typedef uint64_t iscsi_cnx_t;		/* iSCSI Data-Path connection handle */
> 
> Do you really have to create a new typedef?  Please reconsider.  Just
> use u64 everywhere, unless you need to do type checking...

it is a handle and it is used as a parameter in exported API. yes. type
checking exactly the reason.

Dima


