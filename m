Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbTF2T2F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 15:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbTF2T2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 15:28:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63893 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262148AbTF2T2A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 15:28:00 -0400
Date: Sun, 29 Jun 2003 20:42:15 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jamie Lokier <jamie@shareable.org>
Cc: "Leonard Milcin Jr." <thervoy@post.pl>,
       LKML <linux-kernel@vger.kernel.org>, mlmoser@comcast.net,
       john@grabjohn.com
Subject: Re: File System conversion -- ideas
Message-ID: <20030629194215.GG27348@parcelfarce.linux.theplanet.co.uk>
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl> <20030629192847.GB26258@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030629192847.GB26258@mail.jlokier.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 29, 2003 at 08:28:47PM +0100, Jamie Lokier wrote:
> Consider that many people choose ext3 rather than reiser simply
> because it is easy to convert ext2 to ext3, and hard to convert ext2
> to reiser (and hard to convert back if they don't like it).  I have
> seen this written by many people who choose to use ext3.  Thus proving
> that there is value in in-place filesystem conversion :)

Uh-huh.  You want to get in-kernel conversion between ext* and reiserfs?
With recoverable state if aborted?  Get real.
