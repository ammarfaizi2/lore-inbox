Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278797AbRJZSQW>; Fri, 26 Oct 2001 14:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278807AbRJZSQL>; Fri, 26 Oct 2001 14:16:11 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:1779 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S278797AbRJZSQF>; Fri, 26 Oct 2001 14:16:05 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Fri, 26 Oct 2001 12:16:28 -0600
To: Alex Larsson <alexl@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dnotify semantics
Message-ID: <20011026121628.O23590@turbolinux.com>
Mail-Followup-To: Alex Larsson <alexl@redhat.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0110261139190.10309-100000@mjc.meridian.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110261139190.10309-100000@mjc.meridian.redhat.com>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 26, 2001  11:48 -0400, Alex Larsson wrote:
> Currently when monitoring a directory using dnotify you get notifications 
> whenever some file in the directory changes, or is added/removed. But when 
> the directory itself is changed (i.e. chmoded) you don't get any notification.

So, monitor the parent of the directory in question for attribute changes.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

