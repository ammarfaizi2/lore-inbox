Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbWFVJDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbWFVJDj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 05:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWFVJDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 05:03:38 -0400
Received: from gw.openss7.com ([142.179.199.224]:23489 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S932531AbWFVJDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 05:03:37 -0400
Date: Thu, 22 Jun 2006 03:03:36 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Theodore Tso <tytso@mit.edu>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 2/8] inode-diet: Move i_pipe into a union
Message-ID: <20060622030336.A5792@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org
References: <20060619152003.830437000@candygram.thunk.org> <20060619153108.720582000@candygram.thunk.org> <Pine.LNX.4.61.0606191918310.23792@yvahk01.tjqt.qr> <20060619190610.GH15216@thunk.org> <20060620092351.E10897@openss7.org> <20060621014537.GC5663@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060621014537.GC5663@thunk.org>; from tytso@mit.edu on Tue, Jun 20, 2006 at 09:45:37PM -0400
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore,

On Tue, 20 Jun 2006, Theodore Tso wrote:
> 
> In any case, when you state authoratively what "can" and "can not" be
> combined, please specify when your justification is for a particular
> out of tree modules.

In that case, be my guest: combine i_pipe with i_private: see if what
you break is worth the gain.

