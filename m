Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265508AbTAJRwY>; Fri, 10 Jan 2003 12:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265513AbTAJRwX>; Fri, 10 Jan 2003 12:52:23 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:1170 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265508AbTAJRwU>;
	Fri, 10 Jan 2003 12:52:20 -0500
Subject: [ANNOUNCE] LTP-20030110
From: Jeff Martin <ffej@us.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 10 Jan 2003 12:00:29 -0600
Message-Id: <1042221629.26817.20.camel@bfe.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Test Project test suite LTP-20030110.tgz has been released.
Visit our website (http://ltp.sourceforge.net) to download the latest
version of the testsuite, and for information on test results on
pre-releases, release candidates & stable releases of the kernel. There 
is also a list of test cases that are expected to fail, please find 
the list at (http://ltp.sourceforge.net/expected-errors.php)

The highlights of this release are:

- Many new tests from Wipro.
- Many new SPIE tests ported. 
- More than 40 new tests.
- LTP now has over 900 tests.
- Many bug-fixes

We encourage the community to post results, patches, or new tests on our
mailing list, and to use the CVS bug tracking facility to report
problems that you might encounter. More details available at our
web-site.


ChangeLog
----------

- Added New test case to test 'file' command.     ( Manoj Iyer )
- Added new test to test basic functionality of   ( Manoj Iyer )
  CRONTAB, CRON etc.
- Added new test case to test eject command       ( Manoj Iyer )
- Added new tests to test logrotate               ( Manoj Iyer )
- Added new testcase to test basic functionality  ( Manoj Iyer )
  of tar command.
- Fixed mem01: The free memory size was being     ( Robbie Williamson )
  incorrectly calculated, plus it could not
  handle large amounts of memory...now using
  long int, instead of int.
- Fixed mem01: Test was not cleaning up correctly ( Robbie Williamson )
  after a failure.
- Initial checkin of shmt, shared memory tests    ( Robbie Williamson )
  from SPIE suite
- Initial checkin of pty testcases: hangup01(),   ( Robbie Williamson )
  ptem01() and pty01() from SPIE testsuite.
- Added code to abort01.c to use the              ( Robbie Williamson )
  tst_tmpdir()/tst_rmdir() APIs
- Added ported abort() test                       ( Ananda Venkataraman)
- Added adjtimex() tests                          ( Saji Kumar )
- Added capget() tests                            ( Saji Kumar )
- Added capset() tests                            ( Saji Kumar )
- Added ported test, creat08                      ( Airong Zhang )
- create08 was initially ported to create users   ( Robbie Williamson )
  and groups that it needed. Rewrote the test to
  use existing users/groups that are checked for
  when the LTP is installed.
- Applied patch to create_module02 from creator   ( T.L.Madhu )
- Applied patch to delete_module02 from creator   ( T.L.Madhu )
- Added code to delete_module03 to allow tests to ( Robbie Williamson )
  execute under pan.
- Applied patch to delete_module03 from creator   ( T.L.Madhu )
- Added ported dup06 and dup07 tests              ( Airong Zhang )
- Added ported dup202 and dup205 tests            ( Airong Zhang )
  and cleaned up some other files
- Initial checkin of fdatasync() tests            ( T.L. Madhu )
- Added new flock04 and flock05 tests             ( Vatsal Avasthi )
- Added ported fmtmsg() test                      ( Ananda Venkataraman)
- Added functional test to gethostid01 to compare ( Paul Larson )
  result from gethostid() versus the hostid
  command
- Initial checkin of getrusage() tests            ( Saji Kumar )
- Added ioperm() tests                            ( Subhabrata Biswas )
- Added iopl() tests                              ( Subhab Biswas )
- Added ported kill() tests                       ( Ananda Venkataraman)
- Added ported mallopt() test                     ( Ananda Venkataraman)
- Added ported memcmp() test                      ( Ananda Venkataraman)
- Added ported memcpy() test                      ( Ananda Venkataraman)
- Added ported memset() test                      ( Ananda Venkataraman)
- Fixed mkdir09: the getopts() call was returning ( Robbie Williamson )
  it's -1 to a char variable.  This was incorrect
  and causing the test to loop forever on certain
  architectures.
- Initial checkin of munlockall() tests           ( Sowmya Adiga )
- Fixed nftw64: tst_rmdir was in the wrong        ( Robbie Williamson )
  location.
- Added ported open09() test                      ( Airong Zhang )
- Initial checkin of prctl() tests                ( Saji Kumar )
- Added ported profil() test                      ( Ananda Venkataraman)
- Initial checkin of ptrace() tests               ( Saji Kumar )
- Added code to query_module tests to allow       ( Robbie Williamson )
  execution under pan.
- Initial checkin of reboot() tests               ( Aniruddha Marathe )
- Initial checkin of sched_rr_get_interval tests  ( Saji Kumar )
- Added setresgid() tests                         ( T.L. Madhu )
- Fixed setrlimit03 to work on 2.5 and cleanup    ( Paul Larson )
- Added socketcall() tests                        ( Adiga Sowmya )
- Added ported string.h test string01             ( Ananda Venkataraman)
- Added swapoff() tests                           ( Aniruddha Marathe )
- Added swapoff() tests                           ( Aniruddha Marathe )
- Added swapon() test                             ( Aniruddha Marathe )
- Made corrections to swapon02 to make sure the   ( Robbie Williamson )
  child exits.
- Added ported syscall() test                     ( Ananda Venkataraman)
- Removed an erroneous testcase in sysconf01 and  ( Robbie Williamson )
  corrected a typo issue.
- Initial checkin of sysfs() tests                ( Aniruddha Marathe )
- Made changes to allow the syslog tests to       ( Robbie Williamson )
  execute in pan and corrected a bug in backup
  code for syslog.conf original file.
- Added syslog11 & syslog12 tests                 ( T.L. Madhu )
- Fixed syslogtst if-statement comparing a file   ( Robbie Williamson )
  descriptor to a hardcoded number was changed to
  allow the test to run under pan.
- Changed the file opened for the 6th case in     ( Robbie Williamson )
  syslogtst.
- Added ported abs() test                         ( Ananda Venkataraman)
- Added ported atof() test                        ( Ananda Venkataraman)
- Added ported nextafter() test                   ( Ananda Venkataraman)
- Corrected bug in cleanup section of fsx.sh      ( Robbie Williamson )
- Added code to rusers01 to change a FQDN in      ( Robbie Williamson )
  RHOST to short name.
- Fixed testsf_c bug in char* not large enough to ( Robbie Williamson )
  hold argv[4] string.
- Added command line version of LTP harness APIs  ( Manoj Iyer )
  these commands will print LTP test results in
  LTP harness format just like the ones printed
  by C testcases.  These commands can be used in
  shell scripts and other non-C testcases.
- Added load generator tool, stress               ( Amos Waterland )
- Modified runalltests.sh to print default        ( Manoj Iyer )
  settings
- Modified runalltests.sh to run LTP under stress ( Manoj Iyer )




Jeff Martin (ffej_AT_us.ibm.com)
Linux Test Project
IBM Linux Technology Center

