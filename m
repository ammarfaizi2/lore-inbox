Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbRGEMTm>; Thu, 5 Jul 2001 08:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264990AbRGEMTc>; Thu, 5 Jul 2001 08:19:32 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:52752 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S264984AbRGEMTS>; Thu, 5 Jul 2001 08:19:18 -0400
Date: Thu, 5 Jul 2001 14:15:01 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Naveen Kumar Pagidimarri <naveen.pagidimarri@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: [OT] Re: source for ps command
Message-ID: <20010705141501.H30999@arthur.ubicom.tudelft.nl>
In-Reply-To: <GG00WE00.AFQ@vindhya.mail.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <GG00WE00.AFQ@vindhya.mail.wipro.com>; from naveen.pagidimarri@wipro.com on Thu, Jul 05, 2001 at 05:20:38PM +0530
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2001 at 05:20:38PM +0530, Naveen Kumar Pagidimarri wrote:
> 	    Please tell me where can i get the source of ps command or 
> 
> 	related source code for the implementation of ps command. 

If you don't get an answer it might be that:

- your question is off topic for this list
- the answer is too trivial to tell
- nobody had time to answer it

In any case don't post the same question within 30 minutes.

Getting the source of a package is simple. On an RPM compatible system
(Red Hat, SuSE, Mandrake):

  erik@merijn:~ >rpm -qf `which ps`
  procps-2.0.6-5
  (get the procps-2.0.6 SRPM from CD or download it from the web)

On a Debian system it's even easier:

  erik@arthur:~ >dpkg -S `which ps`
  procps: /bin/ps
  erik@arthur:~ >apt-get -qq source procps
  dpkg-source: extracting procps in procps-2.0.7


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
