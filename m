Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262723AbREOKZC>; Tue, 15 May 2001 06:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262724AbREOKYx>; Tue, 15 May 2001 06:24:53 -0400
Received: from mx10.port.ru ([194.67.23.89]:40071 "EHLO mx10.port.ru")
	by vger.kernel.org with ESMTP id <S262723AbREOKYi>;
	Tue, 15 May 2001 06:24:38 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: "Vladimir V. Saveliev" <monstr@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re[2]: ReiserFS 2.4.4/3.x.0k-pre2
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.27.26]
In-Reply-To: <3AF6A6D2.B0C285BC@namesys.com>
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E14zc0K-0000ya-00@f6.mail.ru>
Date: Tue, 15 May 2001 14:24:36 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

          Hello,
     I`m still experiencing file tail corruptions
  on subj.
     And more: after i had restored bblocked patrition
  (by relying on drive`s ability to remap bblks on
  write by wroting small modification of debugreiserfs
  which zeroified all bblks), i had _runtime_ tail
   corruptions of the mc`s dir hotlist which i tried 
   to rewrite again and again.
  i found, that "sync"ing after modifying helps to keep
  file fine, so it does until now.
