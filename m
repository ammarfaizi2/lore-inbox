Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbTJAPDF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 11:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbTJAPBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 11:01:49 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:61313 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262354AbTJAPBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 11:01:11 -0400
Date: Wed, 1 Oct 2003 16:01:31 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310011501.h91F1Vt7001306@81-2-122-30.bradfords.org.uk>
To: Jurjen Oskam <jurjen@stupendous.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: lisanels@cableone.net
In-Reply-To: <20031001135322.GA16692@quadpro.stupendous.org>
References: <1065012013.4078.2.camel@lisaserver>
 <20031001135322.GA16692@quadpro.stupendous.org>
Subject: Re: File Permissions are incorrect. Security flaw in Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Jurjen Oskam <jurjen@stupendous.org>:
> On Wed, Oct 01, 2003 at 06:40:13AM -0600, Lisa R. Nelson wrote:
> 
> > [1.] One line summary of the problem:    
> > A low level user can delete a file owned by root and belonging to group
> > root even if the files permissions are 744.  This is not in agreement
> > with Unix, and is a major security issue.
> 
> This *is* in agreement with Unix. It works exactly the same on AIX, for
> example.

Interesting, though, POSIX doesn't define the sticky bit.  What is
even more interesting is that the chmod manual page answers just about
everything that has come up in this thread, and yet it's still wasting
LKML bandwidth.

John.
