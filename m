Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290965AbSCQCQE>; Sat, 16 Mar 2002 21:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310184AbSCQCPr>; Sat, 16 Mar 2002 21:15:47 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:25612 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S290965AbSCQCP3>; Sat, 16 Mar 2002 21:15:29 -0500
Date: Sun, 17 Mar 2002 03:15:27 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Adam Keys <akeys@post.cis.smu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK] Having a hard time updating by pre-patch
Message-ID: <20020317031527.A31674@devcon.net>
Mail-Followup-To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
	Adam Keys <akeys@post.cis.smu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20020317005425.TVMQ1147.rwcrmhc52.attbi.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020317005425.TVMQ1147.rwcrmhc52.attbi.com@there>; from akeys@post.cis.smu.edu on Sat, Mar 16, 2002 at 06:54:00PM -0600
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 06:54:00PM -0600, Adam Keys wrote:
> 
> So far I have found two ways to get from 1.157 to 1.158.  One is to pull from 
> the parent and then undo down to 1.158.  The only other way that has been 
> suggested to me is to pull 1.158 in parallel and then import the patch there.

If you have a clone of the full master 2.5 repository somewhere on
your harddisk, you can go just there and do a

% bk send -r1.158 - | bk receive /your/uml/repository

After that change to your uml repository and do a

% bk resolve

to apply the 1.158 changeset to your uml repository (if you give a
"-a" option to bk receive, bk resolve will be run automatically).

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
